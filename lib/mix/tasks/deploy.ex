defmodule Mix.Tasks.Deploy do
    use Mix.Task

    @app_name Mix.Project.config[:app]
    @app_version Mix.Project.config[:version]
    @install_dir "/opt/#{@app_name}"

    def run(_) do
        System.cmd("mix", ["release"], [ env: [{"MIX_ENV", "prod"}], into: IO.stream(:stdio, :line) ])
        System.cmd("mkdir",  ["-p",  "#{@install_dir}"], [])
        System.cmd("cp", ["_build/prod/rel/#{@app_name}/releases/#{@app_version}/#{@app_name}.tar.gz", "#{@install_dir}"], [])
        System.cmd("tar", ["-xzf", "#{@app_name}.tar.gz"], [cd: @install_dir])
    end
end