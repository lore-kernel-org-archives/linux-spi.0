From: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi_mmc bus concurrency fix
Date: Thu, 28 Feb 2008 11:53:54 +0800
Message-ID: <386072610802271953v3bf01ab5r8fe0c8294fd67733@mail.gmail.com>
References: <47C42D50.7020204@rubico.se>
	<386072610802262023t6bd22875kfeb58c797be66024@mail.gmail.com>
	<200802262046.29906.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, hp-VrBV9hrLPhE@public.gmane.org,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <200802262046.29906.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 27, 2008 at 12:46 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Tuesday 26 February 2008, Bryan Wu wrote:
>  > On Tue, Feb 26, 2008 at 11:16 PM, Hans Eklund <hans-9ai+6vhHfRGzQB+pC5nmwQ@public.gmane.org> wrote:
>
>  >
>  > So we can investigate with the SPI framework update.
>  >
>  > >  There is one messaging scheme that i cant figure out how to create
>  > >  correctly using spi messages and transfers that is important for the
>  > >  MMC/SD SPI protocol.
>
>  I'm not following something here.  Is there another MMC-over-SPI
>  driver being developed?  Why not use the current one?
>

Yes, Hans developed a MMC-over-SPI driver before the mainline implementation.
His SPI_MMC driver has been in Blackfin local repo for a long time.
http://docs.blackfin.uclinux.org/doku.php?id=mmc_driver&s=spi

At beginning this driver does not use the SPI framework API,
now Hans is working on to more his driver to use kernel SPI framework API. Then
He met the bus sharing issue.

>
>

>
>  > >  Note that 'send data+token' can only be done if a specific cmd response
>  > >  was found. Same for data response, if not correct response another path
>  > >  in code will be taken(ask for card status). All this needs to be done
>  > >  "atomically" on the bus. Can this be achieved with the current state of
>  > >  the spi driver?
>
>  As noted above.  There are two issues:  (a) keeping other drivers off
>  the bus, and (b) making sure chipselect doesn't go inactive at the wrong
>  place.
>
>  The *current* assumption is that the bus will be unshared, so (a) isn't
>  an issue ... and that the SPI master controller driver will implement
>  the chipselect hinting mechanism (spi_transfer.cs_change set on the
>  last transfer).
>
>
>  We do need better solutions for (a) though.
>

As we discussed here, the main issue is
a) upper level spi device driver can submit I/O request to spi-core,
spi-core will schedule the real read/write I/O operation to lower
level hardware
b) some spi devices require to make sure atomically bus I/O
transcation which can not be interrupt by other spi devices sharing
the same bus.
spi-core should provide some API to meet this requirement.

-Bryan
