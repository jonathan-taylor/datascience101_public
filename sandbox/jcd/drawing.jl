# drawing.jl
#
# A simple script for making a lot of drawings

using PyPlot;

function DrawEuclideanDistances()
  figure();
  arrow(0, 0, 1, 0, width = .003, head_width = .03, facecolor = "k",
        head_length = .04, length_includes_head = true);
  arrow(1, 0, 0, 1, width = .003, head_width = .02, facecolor = "k",
        head_length = .04, length_includes_head = true);
  arrow(0, 0, 1, 1, width = .003, head_width = .02,
        head_length = .04, facecolor = "k",
        length_includes_head = true);
  axis([-.05, 1.05, -.05, 1.05]);
  text(.5, .04, L"$x_1$", fontsize=24);
  text(.3, .6, L"$\sqrt{x_1^2 + x_2^2}$", fontsize=24, rotation = 37);
  text(.9, .4, L"$x_2$", fontsize=24);
  xticks([]);
  yticks([]);
  savefig("euclidean.jpg", bbox_inches="tight");
end

function DrawNearestNeighbor(npoints::Int64 = 8)
  figure();
  srand(0);
  close_point = [.2; .15];
  rad = norm(close_point);
  sphere_points = rad * [cos(linspace(-.65, 1.2, 30))';
                         sin(linspace(-.65, 1.2, 30))']';
  fill_between([0.0; sphere_points[:, 1]; 0], [0.0; sphere_points[:, 2]; 0],
               edgecolor = (.8, .4, .05), facecolor = (1.0, .9, .5));
  plot(sphere_points[:, 1], sphere_points[:, 2], color = (.8, .4, .05),
       linewidth = 2);
  plot([0], [0], "ko", markersize = 10, label = L"Point $x$");
  plot([close_point[1]], [close_point[2]], color = (1.0, .5, .1), marker = "*",
       markersize = 20, label = "Nearest neighbor");
  plot([close_point[1]], [close_point[2]], color = (0,0,1.0), marker = "s");
  plot(.3 * randn(npoints) + .5, .3 * randn(npoints) + .5, "s", color = (0, 0, 1),
       label = "Farther point");
  axis("equal");
  legend(loc = "upper left");
  text(-.08, .01, L"$x$", fontsize=24);
  savefig("nearest_neighbor.jpg", bbox_inches="tight");
end

function DrawKNearestNeighbor(npoints::Int64 = 8)
  figure();
  srand(0);
  close_points = [.2 .15; .23 .3; .34 .01];
  rad = sqrt(close_points[2, 1]^2 + close_points[2, 2]^2);
  sphere_points = rad * [cos(linspace(0, pi, 61))';
                         sin(linspace(0, pi, 61))']';
  fill_between(sphere_points[:, 1], sphere_points[:, 2],
               -sphere_points[:, 2],
               edgecolor = (.8, .4, .05), facecolor = (1.0, .9, .5), linewidth=2);
  plot([0], [0], "ko", markersize = 10, label = L"Point $x$");
  plot(close_points[:, 1], close_points[:, 2], "*", color = (1.0, .5, .1),
       markersize = 20, label = "Nearest neighbor");
  plot(.3 * randn(npoints) + .5, .3 * randn(npoints) + .5, "s", color = (0, 0, 1),
       label = "Farther point");
  axis("equal");
  legend(loc = "upper left");
  text(-.08, .01, L"$x$", fontsize=24);
  savefig("k_nearest_neighbor.jpg", bbox_inches="tight");
end

function DrawSampling(npoints::Int64 = 200,
                      ntests::Int64 = 8)
  srand(0);
  figure();
  for ii = 1:ntests
    x = (1 - sign(randn(npoints))) / 2;
    plot(1:npoints, cumsum(x) ./ (1:npoints), "b-");
  end
  plot(1:npoints, .5 + 1 ./ sqrt(1:npoints), "k-");
  plot(1:npoints, .5 - 1 ./ sqrt(1:npoints), "k-");
  plot(linspace(1, npoints, 20), .5 + 1 ./ sqrt(linspace(1, npoints, 20)),
       "k^", label = L"$1 / \sqrt{N}$");
  plot(linspace(1, npoints, 20), .5 - 1 ./ sqrt(linspace(1, npoints, 20)),
       "kv", label = L"$-1 / \sqrt{N}$");
  yticks([]);
  axis([0, npoints, 0, 1]);
  xlabel(L"$N$", fontsize=20);
  legend(fontsize=20);
  savefig("deviations.jpg", bbox_inches = "tight");
end

