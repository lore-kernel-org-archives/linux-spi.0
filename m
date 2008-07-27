From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] powerpc/mpc5200: Fix locking on
	mpc52xx_spi driver
Date: Sun, 27 Jul 2008 13:45:37 -0700
Message-ID: <200807271345.37360.david-b@pacbell.net>
References: <20080726062226.10506.65539.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, dwalker-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080726062226.10506.65539.stgit-8FIgwK2HfyId2tlXD8uQ6/kpB+XfMlBf@public.gmane.org>
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

Applying patch mpc52xx-spi-fix0.patch
patching file drivers/spi/mpc52xx_spi.c
Hunk #1 FAILED at 149.
Hunk #2 succeeded at 154 (offset -7 lines).
Hunk #3 succeeded at 311 (offset -7 lines).
1 out of 3 hunks FAILED -- rejects in file drivers/spi/mpc52xx_spi.c
Patch mpc52xx-spi-fix0.patch does not apply (enforce with -f)

... looks like chunk #1 was against something other than
what you posted, and was partly reversed ..


> +static irqreturn_t mpc52xx_spi_irq(int irq, void *_ms)
> +{
> +	struct mpc52xx_spi *ms = _ms;
> +	spin_lock(&ms->lock);

Blank line after variable declaration blocks please ... and
also, since you're not using IRQF_DISABLED when you request
this IRQ, you've got locking trouble here.  Either specify
IRQF_DISABLED (my preference) or use spin_lock_irqsave().

> +	mpc52xx_spi_fsm_process(irq, ms);
> +	spin_unlock(&ms->lock);
>  	return IRQ_HANDLED;
>  }

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
