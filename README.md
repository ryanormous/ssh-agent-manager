
# ssh-agent-manager

  `ssh-agent-manager` is a python3 command line tool that manages
  `ssh-agent` instances.
  
  Its probably only usable on Linux, sorry.
  
  Other instances of `ssh-agent` may be running because they were started by
  X11, or started by systemd configuration, or simply statrted manually.
  Those instances are no concern to `ssh-agent-manager`, and `ssh-agent-manager`
  will only have awareness of them if an instance has its pertinent variables
  exported to the environment.
  
  `ssh-agent-manager` provides convenience features for starting, stopping,
  and finding `ssh-agent` instances.  For a given instance `ssh-agent-manager`
  can output environment variables for `eval` or `export`.  Optionally, it
  will also add an ssh private key identity to an instance when started.
  
  Using multiple instances is simplified, as is restricting identities to a
  a single, distinct identity per agent instance.
  
  Default lifetime for the identity added to the agent is 50 minutes.

## DEPENDENCIES

  There are no additional dependencies, but assumptions are made about the
  executable location of `ssh-agent`, `ssh-add`, and `ssh-keygen`.

## INSTALL

  A Makefile is included for convenience.  This is optional.

## USAGE

  Please see:
  ```
  $ ssh-agent-manager help
  ```

  Optionally, environment variables may be set to suit various use cases.

  `SSH_DIR` as an evironment variable tells `ssh-agent-manager` where
  private key identities can be found.

  `SSH_TMP` as an evironment variable specifies a directory under which
  the `ssh-agent` socket and pid file will be created.

## EXAMPLE

  Show all managed agents, or any non-managed agent which is exported to
  the environment.
  ```
  $ ssh-agent-manager status
  ```

  Output ssh environment variables for a valid, managed agent.
  The agent may be specified by an identity.  The identity is the name
  of the private key file name.
  ```
  $ ssh-agent-manager env --id some_id_rsa
  > SSH_AGENT_PID=64849 SSH_AUTH_SOCK=/run/user/1000/tmp/ssh-agent-174.4134.715/agent.sock
  ```

  Stop an `ssh-agent` instance.
  An identity may be used to specify the instance, if such an instance
  exists.  Otherwise each agent has a "specifier" to select an exact
  `ssh-agent` instance.
  If that instance has exported ssh variables, additional output is
  shown.
  ```
  $ ssh-agent-manager stop --agent 174.4134.715
  > unset SSH_AGENT_PID SSH_AUTH_SOCK
  ```

  Redundant instances are not started if there is already an `ssh-agent`
  running with a given identity.  This means an agent exclusively having
  that identity. An `ssh-agent` can, however, have multiple identities
  if you want.
  ```
  $ ssh-agent-manager start -i some_id_rsa
  > SSH_AGENT_PID=64849 SSH_AUTH_SOCK=/run/user/1000/tmp/ssh-agent-174.4134.715/agent.sock
  ```
  You will get the same output if you run the command again.
  ```
  $ ssh-agent-manager start -i some_id_rsa
  > SSH_AGENT_PID=64849 SSH_AUTH_SOCK=/run/user/1000/tmp/ssh-agent-174.4134.715/agent.sock
  ```

  Note: additional identities would be added by having `SSH_AGENT_PID`
  and `SSH_AUTH_SOCK` in your environment, and then running `ssh-add`.

