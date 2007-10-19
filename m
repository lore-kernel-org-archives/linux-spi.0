From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 02/10] Blackfin SPI driver: use new
	GPIO API and add error handling
Date: Fri, 19 Oct 2007 10:57:30 -0700
Message-ID: <20071019175730.8546323A5F7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <1192158304-8277-1-git-send-email-bryan.wu@analog.com>
	<200710112326.34500.david-b@pacbell.net>
	<1192172077.6247.15.camel@roc-laptop>
	<200710121017.47645.david-b@pacbell.net>
	<386072610710172306m2a0831eds646da3d7c78809bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: cooloney.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <386072610710172306m2a0831eds646da3d7c78809bb-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

> > In fact, if I look at the kernel.org GIT tree, it doesn't have
> > them either.  Your tree must have somehow gotten a bunch of
> > private changes.
>
> Did you apply these patches, or I need resent a new patchset against
> latest Linus GIT tree?

I'm still not quite sure why the patches you sent didn't apply
for me.  Why don't you send refreshed patches to me after RC1.


> I noticed in latest GIT tree the Blackfin SPI driver are modified.

Yes, various cleanup patches.  Missing newlines in dev_*() calls,
class_device removal, remove extra includes, and so forth.  They
might conflict with your patches (I suspect they won't).

That's a big part of why you should arrange to submit patches well
in advance of the merge window opening.  As a rule, maintainers
won't have/make extra time during that window to review and/or fix
nontrivial issues, or address conflicts with other patches.  Try to
submit at least a few weeks before the previous kernel finalizes.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
