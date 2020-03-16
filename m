From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 35/36] dt-bindings: display: convert lgphilips,lb035q02
 to DT Schema
Date: Mon, 16 Mar 2020 11:11:15 +0200
Message-ID: <3bf96f0e-90a8-1513-800f-0168d912fd9f@ti.com>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-36-sam@ravnborg.org>
 <a73da9d3-43b2-3ce7-85e9-8135dbf48e98@ti.com>
 <20200316082607.GA18510@ravnborg.org>
 <a634d733-4b88-9d5a-09a1-c9551d8a077a@ti.com>
 <20200316085311.GA19201@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>,
        Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
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
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ma
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200316085311.GA19201-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 16/03/2020 10:53, Sam Ravnborg wrote:

> We have panel-simple-dsi for DSI simple based panels.
> This binding includes the reg property.
> 
> If we have included DSI panels in panel-simple.yaml, and we likely have
> by accident, then they should be moved to panel-simple-dsi.yaml.
> 
> If they requires anything else then they shall have their
> own binding.
> 
> panel-simple.yaml and panel-simple.dsi.yaml are on purpose
> only for the simple panels and they have:
> "additionalProperties: false" to avoid that a lot
> of extra sneaks in.
> 
> I actually considered shortly a panel-simple-spi.yaml,
> but the few panels I looked at had different names
> for the power-supply so that did not fly.
> I did not check them all - we have today (with this patch-set)
> 9 bindings that references spi-slave.yaml.

Okay, I understand now. Makes sense.

panel-simple.c has dsi_of_match, which lists DSI panels. I was looking at that when I said 
panel-simple binding has DSI panels. At least auo,b080uan01 and osddisplays,osd101t2045-53ts are 
there, and earlier in this series you moved osddisplays,osd101t2587-53ts to panel-simple bindings.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
