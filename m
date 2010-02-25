From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] omap2_mcspi.c: NULL pointer dereference
Date: Thu, 25 Feb 2010 13:14:27 +0200
Message-ID: <94a0d4531002250314o4a1d08cclceb20e991c51d829@mail.gmail.com>
References: <1266953763.32702.49.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-kernel@vger.kernel.org,
	David Brownell <dbrownell@users.sourceforge.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@deeprootsystems.com>,
	Aaro Koskinen <Aaro.Koskinen@nokia.com>,
	spi-devel-general@lists.sourceforge.net,
	gumstix-users@lists.sourceforge.net
To: Scott Ellis <scott@jumpnowtek.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1266953763.32702.49.camel@quad>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 23, 2010 at 9:36 PM, Scott Ellis <scott@jumpnowtek.com> wrote:
> Check spi->controller_state before dereferencing.
>
> Shows up NULL here when using spi_alloc_device()/spi_add_device()
> and spi_add_device() fails before spi_setup(). Calling spi_dev_put()
> on the leftover spi_device results in the error.

This should go to the linux-omap mailing list.

-- 
Felipe Contreras
