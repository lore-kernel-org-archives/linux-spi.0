From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v1 35/36] dt-bindings: display: convert
 lgphilips,lb035q02 to DT Schema
Date: Tue, 17 Mar 2020 07:45:58 +0100
Message-ID: <20200317064558.GA30986@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-36-sam@ravnborg.org>
 <a73da9d3-43b2-3ce7-85e9-8135dbf48e98@ti.com>
 <20200316082607.GA18510@ravnborg.org>
 <a634d733-4b88-9d5a-09a1-c9551d8a077a@ti.com>
 <20200316085311.GA19201@ravnborg.org>
 <3bf96f0e-90a8-1513-800f-0168d912fd9f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
        Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
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
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marco Fr
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3bf96f0e-90a8-1513-800f-0168d912fd9f-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Tomi.

On Mon, Mar 16, 2020 at 11:11:15AM +0200, Tomi Valkeinen wrote:
> On 16/03/2020 10:53, Sam Ravnborg wrote:
> 
> > We have panel-simple-dsi for DSI simple based panels.
> > This binding includes the reg property.
> > 
> > If we have included DSI panels in panel-simple.yaml, and we likely have
> > by accident, then they should be moved to panel-simple-dsi.yaml.
> > 

> panel-simple.c has dsi_of_match, which lists DSI panels. I was looking at
> that when I said panel-simple binding has DSI panels. At least auo,b080uan01
> and osddisplays,osd101t2045-53ts are there, and earlier in this series you
> moved osddisplays,osd101t2587-53ts to panel-simple bindings.

I will clean this up as part of v2.
Thanks.

	Sam
