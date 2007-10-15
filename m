From: "Girish" <girishsg-l0cyMroinI0@public.gmane.org>
Subject: Re: Status of Linux SPI slave
Date: Mon, 15 Oct 2007 21:38:22 +0530
Message-ID: <00bc01c80f45$9d218980$6a8918ac@ent.ti.com>
References: <20071013154747.2F7B023A5F4@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'David Brownell'" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, <roger-UslnteNVNtIXWF+eFR7m5Q@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20071013154747.2F7B023A5F4-ZcXrCSuhvln6VZ3dlLfH/g4gEjPzgfUyLrfjE7I9kuVHxeISYlDBzl6hYfS7NtTn@public.gmane.org>
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

Sorry, my outlook was wrapping up mail automatically, corrected it.

>-----Original Message-----
>From: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:spi-devel-
>general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of David Brownell

>The first task is to come up with a workable design.  Then would
>come implementing it.
>
>
>A second issue is how to factor the programming interface.  The
>notion of an spi_message isn't necessarily wrong, but when should
>it get issued?  How would commands sent by the host be packaged?
>How should chipselect/deselect be visible?

I was looking for such discussion to be started on this thread from quite
some time.
Well, in my case, I have SPI hardware which can work in Master and Slave
mode as well. Specifically speaking, Slave mode capabilities are as same as
Master mode. Only major difference is in chipselect and clock generation.
As such, in this case, notion of spi_message would definitely hold good for
both and also to some extent the whole stack which exists today.

I see in community, some use SPI slave for minimal functionality. As I
understand, we have to have a stack support for
1. SPI in slave side transaction (as similar as Master's).
2. SPI in slave side transaction with minimal functionality.

I don't know how the latter one is. But, in my case I was able to modify
the controller driver to work for Master/Slave with full transaction
without any stack changes. I know this is bad, as stack would never come to
know about the slave side transaction :).
I would like to know the best way we can make the stack know slave side
transaction happening?



Regards,
girish

>
>
>-------------------------------------------------------------------------
>This SF.net email is sponsored by: Splunk Inc.
>Still grepping through log files to find problems?  Stop.
>Now Search log events and configuration files using AJAX and a browser.
>Download your FREE copy of Splunk now >> http://get.splunk.com/
>_______________________________________________
>spi-devel-general mailing list
>spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/spi-devel-general



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
