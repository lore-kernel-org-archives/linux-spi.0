From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 00/14] Blackfin on-chip SPI
	controller driver updates and bug-fixing
Date: Tue, 30 Oct 2007 13:42:18 -0700
Message-ID: <200710301342.18559.david-b@pacbell.net>
References: <1193735885-8202-1-git-send-email-bryan.wu@analog.com>
	<200710301324.07691.david-b@pacbell.net>
	<8bd0f97a0710301329i8a21b22ncc9f71a81bc06543@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mike Frysinger" <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8bd0f97a0710301329i8a21b22ncc9f71a81bc06543-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Tuesday 30 October 2007, Mike Frysinger wrote:
> On 10/30/07, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > And also, pay closer attention to when you may be making
> > changes that make device drivers work differently over
> > your spi_master controller driver than anyone elses ...
> > such platform-specific behaviors are undesirable, and when
> > they go against specified behavior they are also bugs.
> 
> was there something that caught your eye other than the ugly udelay()
> you mentioned in the other thread ?

That one was a feature that might be more generally necessary,
just to meet chip timing specs.  Mostly they're no trouble.
But sometimes there are constraints around chipselect, or at
particular points in a protocol exchange ... as you know, SPI
has no in-band synchronization, so timing delays are about as
good as any standardized infrastructure can get.  So if that
particular timing tweak was essential to make that driver work,
it might be something the API should address -- instead of just
a particular controller.

The other point was the handling of the two spi_transfer protocol
tweaking options.  The comment went against the interface spec.
Now, maybe that was an issue of weak English skills ... but from
my scanning the patch, I got the impression one intent of that
patch really was to do what the comment said.  (Of course it did
a lot of other stuff, which looked less dubious and might have
had a lot more to do with why the patch made that m25p16 chip
behave on that new board.)

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
