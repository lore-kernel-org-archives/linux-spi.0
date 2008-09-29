From: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] The of_register_spi_devices() was
 not called after registering the spi master.
Date: Mon, 29 Sep 2008 17:04:47 +0200
Message-ID: <48E0EE8F.1000200@denx.de>
References: <1222417480-3144-1-git-send-email-sbabic@denx.de>
	<1222417480-3144-2-git-send-email-sbabic@denx.de>
	<20080929141230.GA9448@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080929141230.GA9448-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Grant Likely wrote:
> Preferred form is:
> 
> 	ret = mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
> 					irq_of_parse_and_map(op->node, 0), id);
> 	if (ret)
> 		return ret;
> 
> Burying the assignment inside the if() makes the code harder to read and
> understand.

Thanks, understood. I will avoid in future to use this encryptic form ;)

I have another issue about this driver that I have found recently.
According to the MPC5200 manual the "tdfOnExit" flag must be set on the
last byte we want to send and the PSC controller holds SS low until the
flag is set.
However, this flag is set always on the last byte written into the FIFO,
independently if it is the last byte of the whole transfer:

                for (; send_at_once; sb++, send_at_once--) {
                        /* set EOF flag before the last word is sent */
                        if (send_at_once == 1)
                                out_8(&psc->ircr2, 0x01);

This generates spurious toggling of the SS signal that breaks the
protocol of some peripherals when we have to send more than 512 bytes.
(I have a peripheral that requires a start byte as first byte after SS
goes low).
IMHO this is a bug, because changing of the SS signal must be ruled only
by the cs_change field in the spi_transfer structure. However, it seems
nobody complains about this and probably it is not seen as a bug...

Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
=====================================================================


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
