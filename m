From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] The of_register_spi_devices()
	was	not called after registering the spi master.
Date: Mon, 29 Sep 2008 16:39:27 -0600
Message-ID: <20080929223927.GB18313@secretlab.ca>
References: <1222417480-3144-1-git-send-email-sbabic@denx.de>
	<1222417480-3144-2-git-send-email-sbabic@denx.de>
	<20080929141230.GA9448@secretlab.ca> <48E0EE8F.1000200@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <48E0EE8F.1000200-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Sep 29, 2008 at 05:04:47PM +0200, Stefano Babic wrote:
> I have another issue about this driver that I have found recently.
> According to the MPC5200 manual the "tdfOnExit" flag must be set on the
> last byte we want to send and the PSC controller holds SS low until the
> flag is set.
> However, this flag is set always on the last byte written into the FIFO,
> independently if it is the last byte of the whole transfer:
> 
>                 for (; send_at_once; sb++, send_at_once--) {
>                         /* set EOF flag before the last word is sent */
>                         if (send_at_once == 1)
>                                 out_8(&psc->ircr2, 0x01);
> 
> This generates spurious toggling of the SS signal that breaks the
> protocol of some peripherals when we have to send more than 512 bytes.
> (I have a peripheral that requires a start byte as first byte after SS
> goes low).
> IMHO this is a bug, because changing of the SS signal must be ruled only
> by the cs_change field in the spi_transfer structure. However, it seems
> nobody complains about this and probably it is not seen as a bug...

Yes, this is a bug.  Some boards do the SS with a GPIO instead of using
the SS pin and so probably see this problem.  It should be fixed.

g.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
