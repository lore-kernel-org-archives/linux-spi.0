From: Jason Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH 0/6] add spi support for i.MX51 in the existing spi_imx
	driver
Date: Fri, 03 Sep 2010 11:18:21 +0800
Message-ID: <4C8068FD.1090705@gmail.com>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<20100902082759.GE14214@pengutronix.de>
	<4C7F777E.1090104@gmail.com>
	<20100902143908.GK14214@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Cc: Jason Wang <jason77.wang@gmail.com>, s.hauer@pengutronix.de,
	grant.likely@secretlab.ca, amit.kucheria@canonical.com,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100902143908.GK14214@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Uwe Kleine-K=F6nig wrote:
> Hello Jason,
>
>   =

>>> Actually I would prefer our patches, but of course I'm biased :-)
>>>
>>> I don't know how we should handle this.  And Sascha is on vacation this
>>> and next week.  I will investigate if our patches are already free to be
>>> posted.
>>>       =

> OK, I can post our patches.  I think the driver part is quite similar,
> the platform part is not.  But look for yourself, I'll post them in reply=
 to
> this mail.  Hopefully we can join forces to get the best out of the two
> approaches.
>   =

OK, glad to see the refine of platform header files.
> BTW, we're working on nand (David merged an early patch series by
> Sascha, we have some fixes pending), mc19892 and ipuv3, too.  Just to
> notice the possibility for more cooperation early. :-)
>
>   =

Good news, after add sdma, mc13892 and ipuv3, the i.MX51 will
be like a real useful platform. :-)
> Best regards
> Uwe
>
>   =
