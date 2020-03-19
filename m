From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 0/36] dt-bindings: display: convert remaning panel
 bindings to DT Schema
Date: Wed, 18 Mar 2020 21:25:28 -0600
Message-ID: <20200319032528.GL29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
        Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Brian Masney <masneyb-1iNe0GrtECGEi8DpZVb4nw@public.gmane.org>,
        Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Guido Gunther <agx-wGvLLbajjwFAfugRpC6u6w@public.gmane.org>, Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>,
        Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>,
        Hoegeun Kwon <hoegeun.kwon-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>,
        Jerry Han <hanxu5-dyavHbARFqWrZjcNGxgArdPArS5jOdiE2SarAXORi/o@public.gmane.org>,
        Jonathan Bakker <xc-racer2-kt+e9JA1QaI@public.gmane.org>,
        Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
        Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marco Franchi <marco.franchi-3arQi8VN3Tc@public.gmane.org>,
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200315134416.16527-1-sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Mar 15, 2020 at 02:43:40PM +0100, Sam Ravnborg wrote:
> Convert remaining(*) panel bindings to DT Schema.
> 
> To prepare for the migration a few preparations
> patches was required:
> 
> - te-gpios is now added to panel-common - as this
>   property is used by a few bindings.
> 
> - The slave part of spi-controller.yaml was migrated to a
>   new file spi-slave.yaml.
>   This was done so spi slaves in panel/ could include
>   this file rather than duplicate property names.
>   => Please review this carefully!
> 
> 
> The original author of the panel bindings are listed as maintainer
> in the DT Schema. In the few cases the panel binding was also
> listed in MAINTAINERS I checked that there was a match.
> It was done manually so I may have missed someone.
> 
> All bindings pass dt_binding_check with no warnings.
> 
> - "dt-bindings: display: convert ilitek,ili9322 to DT"
>   The .txt file listed some constrains that I did not manage
>   to capture in the DT Schema.
>   And some properties looks like that could be dropped.
>   => Please take a closer look.
> 
> - "dt-bindings: display: convert sharp,lq101r1sx01 to DT Schema"  
>   The .txt file describes some constrains, as some properties
>   are mandatory for the main challen, but not allowed
>   for the secondary channel.
>   These constraints are not matched in the DT Schema.
>   => Any hints how to do this would be appreciated.
> 
> 
> Patches made on top of drm-misc-next as of today with no other patches.
> 
> (*) Two .txt files reamins:
> - display-timing.txt, points to display-timings.yaml
> - panel-dsi-cm.txt, conversion is included in another patch-set
> 
> 	Sam
> 
> Sam Ravnborg (36):
>       dt-bindings: display: add te-gpios to panel-common
>       dt-bindings: spi: support non-spi bindings as SPI slaves
>       dt-bindings: display: convert samsung,s6e63m0 to DT Schema
>       dt-bindings: display: convert arm,versatile-tft-panel to DT Schema
>       dt-bindings: display: convert boe,himax8279d to DT Schema
>       dt-bindings: display: convert ilitek,ili9322 to DT Schema
>       dt-bindings: display: convert ilitek,ili9881c to DT Schema
>       dt-bindings: display: convert feiyang,fy07024di26a30d to DT Schema
>       dt-bindings: display: convert innolux,p079zca to DT Schema
>       dt-bindings: display: convert innolux,p097pfg to DT Schema
>       dt-bindings: display: convert innolux,p120zdg-bf1 to DT Schema
>       dt-bindings: display: convert jdi,lt070me05000 to DT Schema
>       dt-bindings: display: convert kingdisplay,kd035g6-54nt to DT Schema
>       dt-bindings: display: convert kingdisplay,kd097d04 to DT Schema
>       dt-bindings: display: convert simple lg panels to DT Schema
>       dt-bindings: display: convert lg,lg4573 to DT Schema
>       dt-bindings: display: convert osddisplays,osd101t2587-53ts to DT Schema
>       dt-bindings: display: convert raydium,rm67191 to DT Schema
>       dt-bindings: display: convert rocktech,jh057n00900 to DT Schema
>       dt-bindings: display: convert samsung AMOLED to DT Schema
>       dt-bindings: display: convert samsung,s6d16d0 to DT Schema
>       dt-bindings: display: convert samsung,ld9040 to DT Schema
>       dt-bindings: display: convert samsung,s6e8aa0 to DT Schema
>       dt-bindings: display: convert toppoly panels to DT Schema
>       dt-bindings: display: convert startek,startek-kd050c to DT Schema
>       dt-bindings: display: convert sony,acx565akm to DT Schema
>       dt-bindings: display: convert sitronix,st7701 to DT Schema
>       dt-bindings: display: convert sitronix,st7789v to DT Schema
>       dt-bindings: display: drop unused simple-panel.txt
>       dt-bindings: display: convert sharp,ls043t1le01 to DT Schema
>       dt-bindings: display: convert sharp,lq101r1sx01 to DT Schema
>       dt-bindings: display: convert sharp,ls037v7dw01 to DT Schema
>       dt-bindings: display: convert sharp,lq150x1lg11 to DT Schema
>       dt-bindings: display: convert seiko,43wvf1g to DT Schema
>       dt-bindings: display: convert lgphilips,lb035q02 to DT Schema
>       dt-bindings: display: convert olimex,lcd-olinuxino to DT Schema

I've gone rather quickly thru the series. Other than what I commented 
on, the rest look fine generally. There may be a couple with similar 
comments.

Rob
