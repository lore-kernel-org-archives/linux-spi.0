From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 0/4] spi: dw: fixes, and manages resources migration
Date: Tue, 31 Dec 2013 13:34:25 +0100
Message-ID: <20131231123425.GP8064@book.gsilab.sittig.org>
References: <cover.1388040447.git.baruch@tkos.co.il>
 <20131226115507.GI8064@book.gsilab.sittig.org>
 <20131226121224.GA11794@sapphire.tkos.co.il>
 <20131226154250.GO8064@book.gsilab.sittig.org>
 <20131226203423.GC3873@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131226203423.GC3873@tarshish>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Dec 26, 2013 at 22:34 +0200, Baruch Siach wrote:
> 
> That's what I meant. The "dummy-cs" should be an internal
> chip-select that does not control any slave signal. [ ... ]

Ah, nevermind then, I simply misunderstood. :)  It's good to see
how much thought you already put into this topic.  Thank you
again for working on GPIO backed CS support for the DW-SPI
controller!

Regarding device tree bindings:  Make sure to keep "arbitrary
implementation details" out of the bindings, i.e. only put into
bindings what's related to the hardware, or what _each_ potential
user of this binding needs to do because of hardware features or
hardware limitations, regardless whether this piece of software
is an OS or not or which OS it may be.

So the introduction of another dummy-cs property might be
appropriate given the observed behaviour of the hardware.
Alternatively one might just pick an arbitrary internal CS number
at runtime (probably the highest internal number, i.e. the last
one), which should not be a problem as long as this behaviour is
documented -- GPIOs then can get used for this CS number and all
numbers above, so no functionality is missing.  Mind that this
workaround then is a feature of the Linux driver, and not the DT
binding.

I'm just saying all of this because any DT properties you
introduce not only need to get documented and reviewed, but even
more so because compatibility needs to be kept in the future and
changes are neither easy nor quick.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
