From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: Re:
	=?iso-8859-1?q?=5BPATCH=5D_mpc52xx=5Fpsc=5Fsp?=
	=?iso-8859-1?q?i_setting_the=09tdfOnExit_flag_only_on_the_last_byt?=
	=?iso-8859-1?q?e?=
Date: Wed, 1 Oct 2008 13:12:27 +0200
Message-ID: <200810011312.27678.sr@denx.de>
References: <1222766572-17499-1-git-send-email-sbabic@denx.de>
	<20080930140726.GG18313@secretlab.ca> <48E23473.8060604@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48E23473.8060604-ynQEQJNshbs@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 30 September 2008, Stefano Babic wrote:
> I know, I have not found a way how to tell git-send-email to send
> everything in one e-mail:
>
> git-send-email --to spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org --compose
> --subject  "[PATCH] mpc52xx_psc_spi setting the tdfOnExit flag only on
> the last byte" 001-According-to-the-manual.patch
>
> Probably it is very easy, but I have not found the right way ;)

I generate the patch with "git format-patch -1 -o directory" and then send it 
with "git send-email --to list directory/patch".

Best regards,
Stefan

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
