From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] SPI bit bang: Deactivate CS before
	restoring speed & wordsize
Date: Fri, 7 Mar 2008 17:55:23 -0800
Message-ID: <200803071755.23541.david-b@pacbell.net>
References: <1204905149.29669.22.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1204905149.29669.22.camel-/EMGr9iCeazgSi9v3i4K4Pmbkio/vSLMs0AfqQuZ5sE@public.gmane.org>
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

On Friday 07 March 2008, Joakim Tjernlund wrote:
> Restoring speed & wordsize on mpc83xx disables the controller temporarily
> which makes the SPI outputs floating. This can cause a glich on
> the SPI CLK which makes the slave in the other end unhappy.

This will also cause trouble with any driver using these protocol
tweaking options:

 - per-transfer overrides of speed and/or wordsize
 - leaving chip selected between messages

The mpc83xx driver is not overriding master->transfer, so all of
those are behaviors this driver claims to support...


> Make sure that CS is disabled before restoring speed & wordsize
> so any gliches are ignored by the SPI slave.

I think the correct fix hast to be in mpc83xx_spi_setup_transfer().
If that routine is fixed, the bitbang core won't need to change,
and those protocol tweaking options will just work.

Or else, this patch would need to be accompanied by a patch which
updates spi_mpc83xx to override master->transfer and filter out all
messages which use those protocol tweaking options, so that all the
places this glitch can appear will be addressed.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
