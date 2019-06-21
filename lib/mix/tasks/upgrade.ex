defmodule Mix.Tasks.Upgrade do

    use Mix.Task

    @app_name Mix.Project.config[:app]
    @install_dir "/opt/#{@app_name}"

    def run(args) do
        new_version = List.first(args)
        case upgrade_mix_file(new_version) do
            :ok ->
                IO.puts "Mix file updated with version: #{new_version}"
                upgrade_running_version(new_version)
            end 
    end

    defp upgrade_mix_file(new_version) do
        case File.read("mix.exs") do
            {:ok, project_file} -> 
                current_version = Mix.Project.config()[:version]
                new_content = String.replace(project_file, "version: \"#{current_version}\"", "version: \"#{new_version}\"", global: true)
                File.write("mix.exs", new_content)
           end
    end

    defp upgrade_running_version(new_version) do
        System.cmd("mix", ["release", "--upgrade"], [ env: [{"MIX_ENV", "prod"}], into: IO.stream(:stdio, :line) ])
        System.cmd("mkdir",  ["-p",  "#{@install_dir}/releases/#{new_version}"], [])
        System.cmd("cp", ["_build/prod/rel/#{@app_name}/releases/#{new_version}/#{@app_name}.tar.gz", "#{@install_dir}/releases/#{new_version}/#{@app_name}.tar.gz"], [])
        System.cmd("#{@install_dir}/bin/#{@app_name}", ["upgrade", new_version], [])
    end

end