From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/6] dt-bindings: iio: adc: mcp320x: Update for
 mcp3550/1/3
Date: Sun, 10 Sep 2017 14:36:04 +0100
Message-ID: <20170910143604.3431d17c@archlinux>
References: <cover.1503407738.git.lukas@wunner.de>
        <87644503b0397248c06fbe0058f292955dd10f79.1503407738.git.lukas@wunner.de>
        <20170825195941.iylf4w5hitjwniio@rob-hp-laptop>
        <20170827153405.GA13399@wunner.de>
        <CABjU8GvCB61envBiR0ei3gHEPadd5VDZ7FGysDjhCrJcQrEXDg@mail.gmail.com>
        <20170903143429.749be480@archlinux>
        <20170904172221.47si6swykixnb5of@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Adriana Reus <adi.reus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>,
        Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
        Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>,
        Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
        Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>,
        Oskar Andero <oskar.andero-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Andrea Galbusera <gizero-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Manfred Schlaegl <manfred.schlaegl-RbZlAiThDcE@public.gmane.org>,
        Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>,
        Soeren Andersen <san-KGKi0rHxN0fKWSuBa/xFvVpr/1R2p/CL@public.gmane.org>,
        linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Abhisit Sangjan <s.abhisit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170904172221.47si6swykixnb5of-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 4 Sep 2017 18:22:21 +0100
Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Sun, Sep 03, 2017 at 02:37:49PM +0100, Jonathan Cameron wrote:
> 
> > +cc Mark Brown and linux-spi to address question about how to represent
> > a hardwired chip select.  See below for why I think that is what we should
> > be representing rather than the fact it puts it in 'continuous mode'.  
> 
> There's a good chance that if you just send me mail with a not obviously
> related subject line it might get discarded unread, people CC me on lots
> of things that are of questionable relevance.
> 
> > > >> > +   - microchip,continuous-conversion (boolean):
> > > >> > +                   Only applicable to MCP3550/1/3:  These ADCs have long
> > > >> > +                   conversion times and therefore support "continuous
> > > >> > +                   conversion mode" to allow retrieval of conversions
> > > >> > +                   at any time without observing a delay.  The mode is
> > > >> > +                   enabled by permanently driving CS low, e.g. by wiring
> > > >> > +                   it to ground.    
> 
> > hmm.  This is odd.  We probably need to make the SPI subsystem aware of this.
> > It is possible to ask for exclusive use of an SPI bus and I think we should
> > be doing this here.  It may be wired low on your board, but it may be wired to  
> 
> This sounds like SPI_NO_CS, though it's vanishingly rare for it to be
> implemented as there's a lot of ways for it to go wrong electrically -
> it's a lot simpler to just have a chip select and minimise the number of
> times it gets asserted.

Thanks Mark.  It sounds like we don't actually need it for the driver under
consideration on the particular platform it is being used on.  If it comes
up later, then adding bindings for SPI_NO_CS and adding relevant support
in the driver looks the way to go to me.

Jonathan


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
