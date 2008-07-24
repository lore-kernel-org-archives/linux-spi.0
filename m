From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [spi-devel-general] [Patch 1/4] Industrialio Core
Date: Thu, 24 Jul 2008 12:56:09 +0100
Message-ID: <48886DD9.7040906@cam.ac.uk>
References: <488763AD.4050400@gmail.com> <488765A5.3040703@gmail.com> <488844F4.1090809@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jonathan Cameron <Jonathan.Cameron@gmail.com>,
	mgross@linux.intel.com, Dmitry Torokhov <dtor@mail.ru>,
	LKML <linux-kernel@vger.kernel.org>,
	LM Sensors <lm-sensors@lm-sensors.org>,
	David Brownell <david-b@pacbell.net>, hmh@hmh.eng.br,
	Jean Delvare <khali@linux-fr.org>,
	spi-devel-general@lists.sourceforge.net,
	Ben Nizette <bn@niasdigital.com>
To: Eric Piel <eric.piel@tremplin-utc.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756671AbYGXL4T@vger.kernel.org>
In-Reply-To: <488844F4.1090809@tremplin-utc.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Eric Piel wrote:
> Jonathan Cameron schreef:
> :
>> +
>> +static void __exit iio_exit(void)
>> +{
>> +	unregister_chrdev(IIO_MAJOR, "bob");
> bob?! Maybe you meant "industrialio" ?
> 
> See you,
> Eric
>
Good spot ;)

Jonathan
