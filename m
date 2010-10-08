From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/2 V2] Adding support for adis16250/5 to adis16260 driver.
Date: Fri, 08 Oct 2010 13:12:00 -0700
Message-ID: <1286568720.1723.4.camel@helium>
References: <1283786178-6466-1-git-send-email-jic23@cam.ac.uk>
	<4C94B4A6.2060001@cam.ac.uk>
	<AANLkTinQ04UmbBvakGQBeSap0PCh3VrWmhhobLh0u9Qj@mail.gmail.com>
	<4CA0C7AB.8060905@cam.ac.uk>
	<AANLkTikXMycs_eaRGA4Va=uaBo_qyx3S3m0Y43Gt+qAz@mail.gmail.com>
	<4CA344A5.80205@cam.ac.uk> <4CAEFEF4.4040506@cam.ac.uk>
	<20101008182943.GJ3863@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: drivers-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, matthias <mensch0815-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101008182943.GJ3863-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 2010-10-08 at 12:29 -0600, Grant Likely wrote:
> On Fri, Oct 08, 2010 at 12:22:28PM +0100, Jonathan Cameron wrote:

> > Is it ever wrong to over specify elements of a transfer?

I wouldn't say that's even possible.

> > We have a driver that (for historical reasons) specifies
> > that a particular transfer is 8 bit.
> > 	.bits_per_word = 8,
> > 
> > This causes issues with the atmel spi driver which sees that
> > the value is specified and hence fails the transfer.


Specifying 8 there means the same as specifying zero.



------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
