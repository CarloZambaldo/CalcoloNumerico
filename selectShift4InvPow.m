function [] = selectShift4InvPow(vett_autoval, sigmaTilde)
	% Questa funzione mostra il diagramma di Voronoi nel piano complesso
	% per aiutare a selezionare uno shift nel metodo delle potenze inverse.

	% Rende univoci gli autovalori
	vett_autoval = unique(vett_autoval);

	% Coordinate (Re, Im) degli autovalori
	x = real(vett_autoval);
	y = imag(vett_autoval);

	% Plot del diagramma di Voronoi
	figure;
	voronoi(x, y, 'k')
	hold on
	plot(x, y, 'ro', 'MarkerFaceColor', 'r')

	% Etichette
	title('Voronoi diagram of eigenvalues in the complex plane')
	xlabel("Real part of the Shift")
	ylabel("Imaginary part of the Shift")
	axis equal
	grid on

	% Se viene passato uno shift, calcola l'autovalore più vicino
	if nargin > 1
		[~, idx] = min(abs(sigmaTilde - vett_autoval));
		lambda_conv = vett_autoval(idx);

		% Verifica della stabilità locale
		eps_pert = 1e-15;
		angles = linspace(0, 2*pi, 9); % 8 direzioni + 0
		sigma_pert = sigmaTilde + eps_pert * exp(1i * angles);

		% Calcola a quale autovalore converge ciascun punto perturbato
		closest_idx = zeros(size(sigma_pert));
		for k = 1:length(sigma_pert)
			[~, closest_idx(k)] = min(abs(sigma_pert(k) - vett_autoval));
		end

		% Controllo: convergono tutti allo stesso autovalore?
		if any(closest_idx ~= idx)
			warning("Lo shift sigma e' troppo vicino al bordo tra due regioni di convergenza!");
			% Evidenzia i punti perturbati
			plot(real(sigma_pert), imag(sigma_pert), 'mx', 'MarkerSize', 6, 'LineWidth', 1.5)
			text(real(sigmaTilde), imag(sigmaTilde)-0.1, 'Vicino al bordo!', ...
				'HorizontalAlignment','center', 'Color','m', 'FontWeight','bold')
        else
            % Plot del punto shift scelto
		    plot(real(sigmaTilde), imag(sigmaTilde), 'bx', 'MarkerSize', 10, 'LineWidth', 2)
		    text(real(sigmaTilde), imag(sigmaTilde), '  \sigma', 'FontWeight', 'bold', 'Color', 'b')
    
		    % Annotazione dell’autovalore associato
		    plot(real(lambda_conv), imag(lambda_conv), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 3)
        end
	end
end
