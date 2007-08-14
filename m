From: llandre <r&d2-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org>
Subject: Re: R: spi_async and heavy CPU occupation by
 ksoftirqd
Date: Tue, 14 Aug 2007 10:29:36 +0200
Message-ID: <46C167F0.4040100@dave-tech.it>
References: <FLEPLOLKEPNLMHOILNHPIEKIDKAA.a.paterniani@swapp-eng.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <FLEPLOLKEPNLMHOILNHPIEKIDKAA.a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
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

AFAIK introducing support for RDY in the driver is not a trivial matter.
Since
a) I just need to perform 1-byte transactions to communicate with 
Quantum QT510
b) I don't have much time to spend on this issue (customer needs to 
assemble a demo quickly)
I'm afraid I'll have to write a dirty patch just to make my specific 
configuration work.

I'll keep you informed anyway.

Regards,
llandre

DAVE Electronics System House - R&D Department
web:   http://www.dave-tech.it
email: r&d2-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org



> You're right the current version of the driver doesn't support RDY control.
> Infact SPI_DEFAULT_CONTROL is defined with SPI_CONTROL_DRCTL_0.
> Also setup function doesn't managed DRCTL changes.
> 
> Then you probably changes SPI_DEFAULT_CONTROL to use SPI_CONTROL_DRCTL_2.
> 
> Please do your suggestions for driver modification in order to release a driver patch.
> 
> - Andrea


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
