module.exports = {
    apps: [
      {
        name: "nubit-node",
        script: "./start.sh",
        cwd: "/root/nubit-node",
        interpreter: "/bin/bash",
        watch: false,
        env: {
          NODE_ENV: "production"
        },
        error_file: "/root/logs/nubit-node-error.log",
        out_file: "/root/logs/nubit-node-out.log",
        log_file: "/root/logs/nubit-node-combined.log",
        time: true
      }
    ]
  };