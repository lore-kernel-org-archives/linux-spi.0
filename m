From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 6/6] of_spi: Initialize cs_gpios and cs_gpio with -EEXIST
Date: Tue, 12 Feb 2013 18:01:43 +0000
Message-ID: <20130212180143.F15523E0FDC@localhost>
References: <1359471223-4794-1-git-send-email-andreas@gaisler.com> <1359471223-4794-7-git-send-email-andreas@gaisler.com> <20130211002320.824593E0C13@localhost> <511A0F73.50008@gaisler.com>
Cc: Rob Herring <rob.herring@calxeda.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree-discuss@lists.ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, software@gaisler.com
To: Andreas Larsson <andreas@gaisler.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <511A0F73.50008@gaisler.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 12 Feb 2013 10:46:27 +0100, Andreas Larsson <andreas@gaisler.com> wrote:
> On 2013-02-11 01:23, Grant Likely wrote:
> > On Tue, 29 Jan 2013 15:53:43 +0100, Andreas Larsson <andreas@gaisler.com> wrote:
> >> Holes in the cs-gpios DT phandle list is supposed to mark that native
> >> chipselects is to be used. The value returned from of_get_named_gpio_flags in
> >> this case is -EEXIST. By initializing cs_gpios and cs_gpio with -EEXIST, this
> >> and only this errno will indicate to a spi controller driver that a native
> >> chipselect is to be used.
> >>
> >> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> >
> > I've left this one off for now. Take a look at the patch I posted and
> > let me know if you think this one should still be applied.
> 
> I think that of_spi_register_master should return an error when the 
> cs-gpios property is broken (part of patch 2) and that cs_gpios and 
> cs_gpio should be initialized to the same value as a hole in the plist.
> 
> This patch does not work without 1 and 2, so I'll submit a modified 
> patch once "of: Create function for counting number of phandles in a 
> property" has stabilized. Would it have to go through the gpio branch then?

I'll put it through the DT branch since that is where I'll put the
of_count_phandle patch (assuming it is ready for the 3.9 merge window).

g.
