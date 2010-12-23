From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [PATCH] mcspi: Add support for GPIO chip select lines
Date: Thu, 23 Dec 2010 18:09:47 -0500
Message-ID: <871v58xf0k.fsf@gmail.com>
References: <1b68c6791001272033q60dd31dbif4de285cd9bac83d@mail.gmail.com> <1292954195-20204-2-git-send-email-bgamari.foss@gmail.com> <AANLkTi=L+ZfwVy+O=oAXx8EHGisCdW1Pg4U+dQa4ZzEN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: beagleboard <beagleboard@googlegroups.com>,
	linux-omap <linux-omap@vger.kernel.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Eric Miao <eric.miao@marvell.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	spi-devel-general <spi-devel-general@lists.sourceforge.net>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=L+ZfwVy+O=oAXx8EHGisCdW1Pg4U+dQa4ZzEN@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 23 Dec 2010 14:38:57 -0700, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Tue, Dec 21, 2010 at 10:56 AM, Ben Gamari <bgamari.foss@gmail.com> wrote:
> > This mechanism is in large part stolen from the s3c64xx-spi module. To
> > use this functionality, one simply must define a set_level function to
> > set the CS state and a omap2_mcspi_csinfo struct for each chip select in
> > the board file.
> >
> > Each spi_board_info.controller_data should then be set
> > to point to the appropriate csinfo struct. This will cause the driver to
> > call the csinfo->set_level function instead of toggling the McSPI chip
> > select lines.
> >
> > Signed-off-by: Ben Gamari <bgamari.foss@gmail.com>
> 
> I'd rather see the spi driver modified to use the gpio api directly.
> The drivers are already tending in that direction and it doesn't
> require machine specific set_level functions to be defined.
> 
The reason I left this up to the board is it's easy to foresee cases
where you want a non-trivial mapping between logical CS numbers and CS
pin states. In my case, I using a 2-to-4 multiplexer as the source of
chip select.

- Ben
