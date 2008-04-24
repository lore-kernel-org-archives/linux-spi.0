From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] SPI: Use "menuconfig" to shorten
	the SPI Kconfig file.
Date: Thu, 24 Apr 2008 12:42:51 -0700
Message-ID: <200804241242.51805.david-b@pacbell.net>
References: <alpine.LFD.1.10.0804241527300.26406@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: "Robert P. J. Day" <rpjday-L09J2beyid0N/H6P543EQg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <alpine.LFD.1.10.0804241527300.26406-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 24 April 2008, Robert P. J. Day wrote:
> =

> A number of dependencies can be removed simply by adding a couple
> "menuconfig" structures.

This partially duplicates a patch already in the MM tree.
Why don't you resubmit, either against MM or (simpler)
after those MM patches are merged?


> also, a lot of that Kconfig file is marked EXPERIMENTAL. =A0is that
> still true?

SPIDEV needs one change before I'd remove that tag, but
probably the BITBANG core can be un-marked.

As for the other code, that's up to the mainter of each
of those controller drivers. =




-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
