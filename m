From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v1 02/36] dt-bindings: spi: support non-spi bindings as
 SPI slaves
Date: Mon, 16 Mar 2020 19:57:33 +0100
Message-ID: <20200316185733.GA18307@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-3-sam@ravnborg.org>
 <20200316120239.GC5010@sirena.org.uk>
 <20200316132844.GA22822@ravnborg.org>
 <20200316163538.GJ5010@sirena.org.uk>
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
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200316163538.GJ5010-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark.

On Mon, Mar 16, 2020 at 04:35:38PM +0000, Mark Brown wrote:
> On Mon, Mar 16, 2020 at 02:28:44PM +0100, Sam Ravnborg wrote:
> > On Mon, Mar 16, 2020 at 12:02:41PM +0000, Mark Brown wrote:
> > > On Sun, Mar 15, 2020 at 02:43:42PM +0100, Sam Ravnborg wrote:
> 
> > > > Independent bindings can be SPI slaves which for example is
> > > > the case for several panel bindings.
> 
> > > What is an "independent binding"?
> 
> > For several panels we have device trees that looks like this:
> 
> So what you're trying to do is define a generic class for SPI slaves
> which are just normal children of SPI nodes?  I really can't get to
> there from your changelog so we need some work there - in particular
> "non-spi bindings" is *very* confusing as as far as I can see these are
> bindings for SPI devices.
> 
> > The bindings are child of the spi controller node, but not specified
> > in the same binding file as the spi controller node.
> 
> Of course not, this how all buses work isn't it?
> 
> > So SPI slaves can now reference spi-slave.yaml to get access to
> > the SPI slave properties - and the copies can be avoided.
> > Likewise spi-controller.yml now references spi-slave.yaml.
> 
> > This was the best way I saw it could be done.
> 
> Rob didn't do the binding conversion but he did review it - I'm a bit
> surprised that there's issues here?

For panels we have panel-common.yaml that list all the
typical properties used by a panel - so the individual
panel bindings shall not repeat them.
This is also aligned with the principle of re-using properties rather
than inventing new properties all over.

And with a number of bindings describing HW that is SPI slaves
the idea is to do something like we do for panels.

I look forward for Rob's feedback - but as he is on vacation this week
we may have to wait a week for that.

The simple way forward had been to do like we do in many other places
and include a few SPI properties and be done with it.
This is an attempt to do something better.
If there is push-back or a nack, then we can always do like we do in
other places and just duplicate the properties.

> Also shouldn't there be some constraint that these devices have to be
> the child of a SPI controller or something?  Just including a file
> doesn't look right for something like class definition.

It was the best I could come up with - and this patch was called out
for review in the hope there is a better way than this patch.

We have similar examples like:
  - pincfg-node.yaml
  - regulatro.yaml
  - dma-common.yaml

They are not exactly 1:1 to what we do with spi-slave.yaml, but they
served as inspiration.

	Sam
