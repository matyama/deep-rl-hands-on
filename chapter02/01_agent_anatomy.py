import random
from typing import List


class Environment:
    """
    Dummy environment that returns random rewards.
    """

    def __init__(self) -> None:
        self.steps_left = 10

    def get_observation(self) -> List[float]:
        """Get current observation from this environment"""
        return [0.0] * 3

    def get_actions(self) -> List[int]:
        """Return currenlty available actions"""
        return [0, 1]

    def is_done(self) -> bool:
        """Returns true when the game is done"""
        return self.steps_left == 0

    def action(self, action: int) -> float:
        """
        Apply given action in this environment.
        Returns random reward.
        """

        # Panic if this method is called when the game is over
        if self.is_done():
            raise Exception("Game is over")

        # Record that a step has been made and return random reward
        self.steps_left -= 1
        return random.random()


class Agent:
    """
    Dummy agent that plays according to a random policy.
    """

    def __init__(self) -> None:
        self.total_reward = 0.0

    def step(self, env: Environment) -> None:
        """
        Make one policy step in given environment.
        """

        # Get current observation from the environment
        #  - Note: This agent actually ignores it.
        _ = env.get_observation()

        # Choose random action
        action = random.choice(env.get_actions())

        # Apply slected action in the environment and collect reward
        reward = env.action(action)
        self.total_reward += reward


if __name__ == "__main__":
    # Create the environment and agent
    env = Environment()
    agent = Agent()

    # Run the game until done
    #  - i.e. run single episode
    while not env.is_done():
        agent.step(env)

    # Show total reward for the episode
    print(f"Total reward: {agent.total_reward:.4f}")
