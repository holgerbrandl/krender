// cd /Users/brandl/projects/kotlin/krender/examples/kravis;   krender.sh iris_vis.kts

//' ## Flowers Analysis

//' The iris flower
//' ![](https://goo.gl/tTbZMq)

@file:MavenRepository("bintray-plugins", "http://jcenter.bintray.com")
@file:DependsOnMaven("com.github.holgerbrandl:kravis:0.3-SNAPSHOT")

import com.github.holgerbrandl.kravis.*
import com.github.holgerbrandl.kravis.Aesthetic.*
import krangl.*

"render"

irisData.ggplot("Species" to x, "Petal.Length" to y)
    .geomBoxplot()
    .geomPoint(position = PositionJitter(width = 0.1), alpha = 0.3)
    .title("Petal Length by Species")


//' The first records in the input data (which is bundled with krangl) are
irisData

//' The structure of the input data is
irisData.schema()

//' Calculate mean petal
val summarizeDf: DataFrame = irisData
    .groupBy("Species")
    .summarize("mean_petal_width") { it["Petal.Width"].mean() }

//' Print the summarized data
summarizeDf.print()

//' Conclusion: Iris flowers of species _virginica_ have on average the largest petal width.