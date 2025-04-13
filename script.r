
library(igraph)

extract_lines <- function(filename)
{
    res = c()
    con <- file(filename, "r")
    while(TRUE)
    {
        line <- readLines(con, 1)
        if(length(line) == 0)
        {
            break
        }
        numbers <- strsplit(line, " ")
        res <- c(res, numbers)
    }
    close(con)
    return(res)
}

create_adj_list <- function(l)
{
    adj_list <- list()

    # Process each line
    for (elements in l) {
        user_id <- elements[1]
        connections <- elements[-1]
        adj_list[[user_id]] <- connections
    }

    return (adj_list)
}

lines = extract_lines("test.txt") # filename goes here
adj_list = create_adj_list(lines)

edge_list <- do.call(rbind, lapply(names(adj_list), function(node) {
  if(length(adj_list[[node]]) > 0) {
    data.frame(from = node, to = adj_list[[node]], stringsAsFactors = FALSE)
  }
}))

g <- graph_from_data_frame(edge_list, directed = TRUE)

plot(g, 
     vertex.size = 20,
     vertex.color = "lightblue",
     vertex.label.color = "black",
     edge.arrow.size = 0.5,
     layout = layout_with_kk)