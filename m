From: Sifan Naeem <Sifan.Naeem@imgtec.com>
Subject: RE: [PATCH 2/2] spi: img-spfi: fix spfi_setup by removing
 gpio_request_one
Date: Mon, 27 Jul 2015 16:53:43 +0000
Message-ID: <A0E307549471DA4DBAF2DE2DE6CBFB7E4966D80C@hhmail02.hh.imgtec.org>
References: <1437999076-693-1-git-send-email-sifan.naeem@imgtec.com>
 <1437999076-693-2-git-send-email-sifan.naeem@imgtec.com>
 <CAL1qeaHLn6-2QJkPjNCm3V-pVqBk09P2BP-Sp+gn1G4ZWpvkEw@mail.gmail.com>
 <20150727164015.GB11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"Stable kernel (v4.1)" <stable@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Andrew Bresticker <abrestic@chromium.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20150727164015.GB11162@sirena.org.uk>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Thanks Mark, Andrew.

I'll rework this and submit a new patch.

Thanks,
Sifan

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: 27 July 2015 17:40
> To: Andrew Bresticker
> Cc: Sifan Naeem; linux-spi@vger.kernel.org; Stable kernel (v4.1)
> Subject: Re: [PATCH 2/2] spi: img-spfi: fix spfi_setup by removing
> gpio_request_one
> 
> On Mon, Jul 27, 2015 at 09:34:41AM -0700, Andrew Bresticker wrote:
> > On Mon, Jul 27, 2015 at 5:11 AM, Sifan Naeem <sifan.naeem@imgtec.com>
> wrote:
> 
> > > spfi_setup may be called many times bye the spi framework, but
> > > gpio_request_one can only be called once without freeing, repeatedly
> > > calling gpio_request_one will cause an error to be thrown, which
> > > causes the request to spi_setup to be marked as failed.
> 
> > > We can simply use gpio_direction_output to set the direction of the
> > > gpio instead of gpio_request_one to put the gpio in to initial
> > > state, after which the spi framework can control the chipselect line
> > > via gpio using gpio_set_value.
> 
> > I don't think we want to leave the CS GPIOs un-requested.  Instead, we
> > could either request them all at probe() time (and then set direction
> > in setup()) or have a per-spi_device flag that indicates whether or
> > not the GPIO has been requested.
> 
> Not requesting the GPIOs at all would just be a straight up bug.
