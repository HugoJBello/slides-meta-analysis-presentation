---
author: Hugo J. Bello
title: Meta-Análisis, qué son y cómo hacerlos
institute: Departamento de Matemática Aplicada, Universidad de Valladolid
fontsize: 9pt
theme: CambridgeUS
---

# Objetivos.

- Comprender qué es un metaanálisis a través de las ideas de
    - tamaño de efecto
    - modelos Fixed Effects y Random Effects
- Entender cómo se hacen los metaanálisis en R de forma sencilla y saber interpretar los resultados
- Tener una idea general de cómo realizar un metaanálisis.


# Introducción. Qué es un Metanálisis
Como definición podemos decir que 

> El metaanálisis es un método sistemático para sintetizar resultados de diferentes estudios empíricos sobre el efecto de una variable independiente, sea de intervención o tratamiento, en un resultado final preciso.

 *Metaanálisis: una forma básica de entender e interpretar su evidencia*,  Vicente Javier Escrig Sosa et Al

# Introducción. Ejemplo

Imaginemos que queremos conocer si el uso de un medicamento reduce los días de hospitalización en pacientes de una enfermedad.  

Acudimos a la bibliografía y encontramos 5 estudios en los que se han realizado ensayos clínicos donde se miden las medias y desviaciones típicas de dias de hospitalización de un grupo experimental y placebo correspondiente a cada estudio.

Tomamos nota de los datos y elaboramos la siguente tabla

# Introducción. Ejemplo

|estudio|tamaño experimental|media hospitalización experimental| $\sigma$ hospitalización experimental|tamaño placebo|media hospitalización placebo| $\sigma$ hospitalización placebo|
|-|-|-|-|-|-|-|
|(1) John Doe et Al.</sub>|20|**8** |3.5|20|**10**|3.1|
|(2) Jack Down et Al.     |15|**9** |4.5|15|**12**|2.5|
|(3) Jane Dew et Al.      |17|**7** |3.5|17|**9** |2.7|
|(4) Joseph Dick et Al.   |30|**12**|2.2|28|**15**|2.8|
|(5) Jonas Dash et Al.    |32|**12**|4.5|31|**9**|3.1|

# Introducción. Ejemplo (observaciones a simple vista)

Observando la tabla anterior vemos que:

- En todos los estudios menos el (5), el grupo placebo presentó una media mayor de días de hospitalización. De lo que se puede concluir que el tratamiento *ha funcionado en la mayoría de los estudios*
  
Podemos preguntarnos: **¿Es suficiente esto para concluir que el tratamiento funciona?**

Esta pregunta es lo que inspira el metanálisis.

# Introducción. Base del metanálisis: **Tamaño del efecto** 

Para entender bien el metanálisis antes debemos entender la idea del **tamaño de efecto** (effect size).

<!-- 
an effect size is a number measuring the strength of the relationship between two variables in a population, or a sample-based estimate of that quantity. It can refer to the value of a statistic calculated from a sample of data, the value of a parameter for a hypothetical population, or to the equation that operationalizes how statistics or parameters lead to the effect size value.
!-->

-  El tamaño del efecto es una medida del la fuerza de la relación entre dos variables de una población
-  En nuestro caso intenta medir de forma empírica lo distintas que son las medidas obtenidas entre los dos grupos placebo y experimental
-  Se usa de forma complementaria a los p-valores en test de hipótesis como los de la t de student

A continuación definiremos el tamaño de efecto más común en nuestro contexto: la **d de Cohen**

# Introducción. d de Cohen. Definición

Se define como 
$$
d = \frac{\overline{X}_{\text{exp}} - \overline{X}_{\text{control}}}{S_\text{agrupado}}
$$

donde
$$
S_\text{agrupado} = \frac{(n_{\text{exp}} - 1) S_{\text{exp}} + (n_{\text{control}} - 1) S_{\text{control}}}{n_\text{exp} + n_\text{control} +2}
$$

# Introducción. d de Cohen. Ejemplo anterior

|estudio|d de Cohen|
|-|-|
|(1) John Doe et Al.</sub>|-0.60|
|(2) Jack Down et Al.     |-0.85|
|(3) Jane Dew et Al.      |-0.64|
|(4) Joseph Dick et Al.   |-1.20|
|(5) Jonas Dash et Al.    |**0.78**|

## Interpretación

- Vemos que los estudios (1), (2), (3), (4) tienen d de Cohen negativo $\Rightarrow$ el número de días de hospitalización  es mayor en el grupo experimental que en el de control ($\overline{X}_{\text{exp}} - \overline{X}_{\text{control}}$)
- En el estudio (5) ocurre lo contrario

# Modelos en metaanálisis: Funcionamiento

Ya hemos entendido el concepto del tamaño de efecto. En la práctica necesitamos un *modelo* que nos diga si el tamaño del efecto es significativo o no, esto es, si el tratamiento produce un efecto notable sobre la variable que estamos estudiando. 

los modelos en este caso funcionan como un test de hipótesis en el que:

-  **la hipótesis nula**: El tratamiento no ha funcionado, es decir que el tamaño de efecto es $0$ para todos los estuos
-  **hipótesis alternativa**: El tratamiento ha funcionado, el tamaño del efecto es distinto de 0.

Como sabemos, los test de hipótesis resultan en un p-valor. Si este p-valor es menor que el nivel de significación $0.05$, rechazamos la hipótesis nula, de lo contrario la aceptamos.


# Modelos en metaanálisis: Fixed effects y Random Effects


Vamos a entender los dos modelos más comunes *Fixed Effects* y *Random effects*. La diferencia fundamental entre ambos radica en asumir si los estudios son homogéneos.

- **Fixed Effects**. Asume que el tamaño del efecto es esencialmente el mismo en todos los estudios. Visto de otra manera que las variaciones en el tamaño del efecto se deben a factores comunes a todos los estudios. $T_i = \mu + \epsilon_i$

- **Random Effects**. Asume que los estudios fueron realizados sobre poblaciones que difieren mucho unos de otros e maneras que pueden influir en el efecto del tratamiento. Factores como variaciones en la *edad*, *intensidad del tratamiento*... $T_i = \mu + \psi_i +  \epsilon_i$


<!--

https://journals.lww.com/ijebh/fulltext/2015/09000/fixed_or_random_effects_meta_analysis__common.12.aspx

As the first criterion, reviewers should consider the goal of statistical inference: is there the intention to generalize the results beyond the included studies (generalization inference)? If the answer is ‘yes’, then the random-effects model is the appropriate statistical model for meta-analysis; is there the intention to apply the results only to the included studies (no generalizations)? If the answer is ‘yes’, then the fixed-effects model is the appropriate statistical model. As we assume that usually reviewers want to generalize the conclusions beyond the actual studies included in meta-analysis, we suggest that the default model for meta-analysis in reviews should be the random-effects model. However, all decision criteria should be considered and the statistical model used should be appropriate from this multicriteria perspective. 

A second criterion to consider directly refers to the number of studies included in the meta-analysis. The fixed-effects model is the appropriate model when the number of studies is small. Random-effects models are appropriate when the number of studies is large enough, that is, enough studies to support generalization inferences beyond the included studies. It was suggested that the fixed-effects model should be used when the number of studies included in a meta-analysis is less than five.34 

A third criterion to consider refers to statistical heterogeneity. The fixed-effects model assumes that all studies included in a meta-analysis are estimating a single true underlying effect. If there is statistical heterogeneity among the effect sizes, then the fixed-effects model is not appropriate. The random-effects model should be considered when it cannot be assumed that true homogeneity exists.
!-->


# Metaanálisis en R: Tamaño del efecto, Fixed effects y Random Effects


Para poder hacer metaanálisis en r debemos primero instalar y cargar varias librerías:

    install.packages("meta")
    install.packages("metafor")
    install.packages("tidyverse")
    # sudo apt-get install libnlopt-dev


    library("meta")
    library("metafor")
    library("tidyverse")

# Metaanálisis en R: cargar datos

cargamos los datos, suponiendo que los tenemos guardados en un csv como este:

    estudio;n_exp;media_exp;sd_exp;n_control;media_control;sd_control
    John Doe et Al.   ;20;8 ;3.5;20;10;3.1
    Jack Down et Al.  ;15;9 ;4.5;15;12;2.5
    Jane Dew et Al.   ;17;7 ;3.5;17;9 ;2.7
    Joseph Dick et Al.;30;12;2.2;28;15;2.8
    Jonas Dash et Al. ;32;12;4.5;31;9 ;3.1

introducimos el siguiente comando para que nos lo lea

    data <- read.csv("./estudios.csv",  header=TRUE, sep=";")

# Metaanálisis en R: Fixed effects

    m.dl <- meta::metacont(n_exp,
                       media_exp,
                       sd_exp,
                       n_control,
                       media_control,
                       sd_control,
                       data=data,
                       studlab=paste(estudio),
                       fixed = TRUE,
                       random = FALSE,
                       method.tau = "SJ",
                       hakn = TRUE,
                       prediction = TRUE,
                       sm = "SMD")

    m.dl

# Metaanálisis en R: Resultado Fixed Effects

        Number of studies combined: k = 5
        Number of observations: o = 225

                                SMD             95%-CI     z p-value
        Common effect model -0.3790 [-0.6527; -0.1054] -2.71  0.0066
        Prediction interval         [-2.8887;  1.9473]              

        Quantifying heterogeneity:
        tau^2 = 0.4638 [0.1202; 4.4177]; tau = 0.6810 [0.3466; 2.1018]
        I^2 = 86.3% [70.0%; 93.7%]; H = 2.70 [1.83; 3.98]

        Test of heterogeneity:
            Q d.f.  p-value
        29.10    4 < 0.0001

        Details on meta-analytical method:
        - Inverse variance method
        - Sidik-Jonkman estimator for tau^2
        - Q-profile method for confidence interval of tau^2 and tau
        - Hedges' g (bias corrected standardised mean difference; using exact formulae)

# Metaanálisis en R: Forest plot Fixed Effects

    forest(m.dl)


![Gráfico fixed effects](data/forest_fixed_effects.png)


# Metaanálisis en R: Random Effects

    m.dl <- meta::metacont(n_exp,
                        media_exp,
                        sd_exp,
                        n_control,
                        media_control,
                        sd_control,
                        data=data,
                        studlab=paste(estudio),
                        fixed = FALSE,
                        random = TRUE,
                        method.tau = "SJ",
                        hakn = TRUE,
                        prediction = TRUE,
                        sm = "SMD")

    m.dl

# Metaanálisis en R: Resultado Random Effects

        Number of studies combined: k = 5
        Number of observations: o = 225

                                SMD            95%-CI     t p-value
        Random effects model -0.4707 [-1.4103; 0.4689] -1.39  0.2366
        Prediction interval          [-2.8887; 1.9473]              

        Quantifying heterogeneity:
        tau^2 = 0.4638 [0.1202; 4.4177]; tau = 0.6810 [0.3466; 2.1018]
        I^2 = 86.3% [70.0%; 93.7%]; H = 2.70 [1.83; 3.98]

        Test of heterogeneity:
            Q d.f.  p-value
        29.10    4 < 0.0001

        Details on meta-analytical method:
        - Inverse variance method
        - Sidik-Jonkman estimator for tau^2
        - Q-profile method for confidence interval of tau^2 and tau
        - Hartung-Knapp adjustment for random effects model
        - Hedges' g (bias corrected standardised mean difference; using exact formulae)

# Metaanálisis en R: Forest plot Random Effects

    forest(m.dl)


![Gráfico random effects](data/forest_random_effect.png)


# Conclusión:  pasos para elaborar un metaanálisis:

- Formulación de la pregunta de investigación teniendo en cuenta el modelo PICO: *Poblacion, intervencion, comparación y resultado*
- Busqueda en la literatura
- Selección de estudios
- Decisión de qué variables o medidas se van a usar: por ej. (medias, diferencias, desviación típica). Normalmente usaremos media y desviación típica.
- Selección de modelo de meta análisis: *Fixed effects* o *random effects*.
- Analizar los resultados.

# Referencias
- Field, A.P. and Gillett, R. (2010), How to do a meta-analysis. British Journal of Mathematical and Statistical Psychology, 63: 665-694. https://doi.org/10.1348/000711010X502733
- Tufanaru, Catalin MD, MPH, MClinSci (EBHC); Munn, Zachary PhD; Stephenson, Matthew PhD; Aromataris, Edoardo PhD Fixed or random effects meta-analysis? Common methodological issues in systematic reviews of effectiveness, International Journal of Evidence-Based Healthcare: September 2015 - Volume 13 - Issue 3 - p 196-207 doi: 10.1097/XEB.0000000000000065 
- A basic introduction to fixed-effect and random-effects models for meta-analysis. Michael Borenstein, Larry V. Hedges, Julian P.T Higgins, Hannah Rothstein. Research Synthesis Methods Volume 1, Issue 2, pages 97–111, April/June 2010

# Materiales
Los materiales de esta charla están disponibles en:


[https://github.com/HugoJBello/materiales_charla_introduccion_metaanalisis](https://github.com/HugoJBello/materiales_charla_introduccion_metaanalisis)