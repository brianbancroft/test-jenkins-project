import React from "react";
import { describe, expect, it } from "vitest";
import "@testing-library/jest-dom";

import App from "./App";

import { render, screen, userEvent } from "../testUtils";

describe("Simple working test", () => {
  it("the title is visible", () => {
    render(<App />);

    const welcomeText = screen.getByText(/Vite \+ React/i);

    expect(welcomeText).toBeInTheDocument();
  });

  it("should increment count on click", async () => {
    render(<App />);

    userEvent.click(screen.getByRole("button"));

    expect(await screen.findByText(/count is 1/i)).toBeVisible();
  });
});
