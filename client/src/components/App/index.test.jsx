import { render, screen } from '@testing-library/react';
import { BrowserRouter as Router } from 'react-router-dom';
import App from '.';

test('renders component', () => {
  render(<Router><App /></Router>);
  const linkElement = screen.getByText(/CREATE REACT/i);
  expect(linkElement).toBeInTheDocument();
});
