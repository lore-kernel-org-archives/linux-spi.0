From: Stefano Babic <stefano.babic-jEVQdWr+paajF4gvJNWmbkB+6BGkLq7r@public.gmane.org>
Subject: Re: Fwd: [PATCH] The	of_register_spi_devices()
 was not called after registering	the spi master.
Date: Thu, 25 Sep 2008 19:37:43 +0200
Message-ID: <48DBCC67.5070307@babic.homelinux.org>
References: <200809242257.13832.david-b@pacbell.net>
	<20080925161657.GA15138@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080925161657.GA15138-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
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
> On Wed, Sep 24, 2008 at 10:57:13PM -0700, David Brownell wrote:
>> From: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
>>
> 
> Patch is missing a description of why it is needed.  I may understand
> it, but will the next person?

Sorry, I have used another time git-send-email with wrong
parameters...and with two different mail addresses,too.

> Also, some trivial whitespace irregularities in this patch, but otherwise...

Sorry about that.

> Personally, I'd do this logic the other way around by putting
> of_register_spi_devices() in the main flow of code and go on an abort
> path if mpc52xx_psc_spi_do_probe() != 0; but I'm not concerned enough
> about it to care or withhold my ack.

I agree with you, I do not know why I did this time in this way...I will
resubmit the patch with the corrections.


-- 
stefano <stefano.babic-jEVQdWr+paajF4gvJNWmbkB+6BGkLq7r@public.gmane.org>
GPG Key: 0x55814DDE
Fingerprint 4E85 2A66 4CBA 497A 2A7B D3BF 5973 F216 5581 4DDE



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
