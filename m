From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] mpc52xx_psc_spi setting the
	tdfOnExit flag only on the last byte
Date: Tue, 30 Sep 2008 08:44:18 -0600
Message-ID: <fa686aa40809300744s77c7069elfd5a6802b3048a24@mail.gmail.com>
References: <1222766572-17499-1-git-send-email-sbabic@denx.de>
	<20080930140726.GG18313@secretlab.ca> <48E23473.8060604@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Stefano Babic" <sbabic-ynQEQJNshbs@public.gmane.org>
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

On Tue, Sep 30, 2008 at 8:15 AM, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org> wrote:
> Grant Likely wrote:
>> Your patchs and descriptions are getting sent in separate emails.  How are you
>> sending your patches?
>
> I know, I have not found a way how to tell git-send-email to send
> everything in one e-mail:
>
> git-send-email --to spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org --compose
> --subject  "[PATCH] mpc52xx_psc_spi setting the tdfOnExit flag only on
> the last byte" 001-According-to-the-manual.patch
>
> Probably it is very easy, but I have not found the right way ;)

You need to provide the patch description when you commit the change,
not when you send the email.

While you cannot edit a commit directly (commits are immutable), you
can create a new commit from the old using git-cherry-pick:

$ man git-cherry-pick
$ git branch old                 # Save the current location
$ git reset --hard old~1         # reset to just before the commit to edit
$ git-cherry-pick -e old         # Cherry pick the commit that you
                                 # want and edit the commit log.

g.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
