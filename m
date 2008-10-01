From: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] mpc52xx_psc_spi setting the
 tdfOnExit flag only on the last byte
Date: Wed, 01 Oct 2008 16:29:24 +0200
Message-ID: <48E38944.7070309@denx.de>
References: <1222766572-17499-1-git-send-email-sbabic@denx.de>
	<20080930140726.GG18313@secretlab.ca>
	<48E23473.8060604@denx.de> <200810011312.27678.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200810011312.27678.sr-ynQEQJNshbs@public.gmane.org>
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
> $ man git-cherry-pick
> $ git branch old                 # Save the current location
> $ git reset --hard old~1         # reset to just before the commit to edit
> $ git-cherry-pick -e old         # Cherry pick the commit that you

Stefan Roese wrote:
> I generate the patch with "git format-patch -1 -o directory" and then send it 
> with "git send-email --to list directory/patch".

Thanks a lot both ! I did not know how to use git-cherry-pick, I have
learned now. By the way, the mistake was trivial (but I have not seen) :
I forgot to add an empty line between subject and text when I commit the
changes and git-send-email took everything as subject ;)

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
