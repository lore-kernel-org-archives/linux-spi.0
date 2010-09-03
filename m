From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/6] spi-imx: add CSPI and eCSPI support for i.MX51 MCU
Date: Fri, 3 Sep 2010 09:54:16 +0200
Message-ID: <20100903075416.GY14214@pengutronix.de>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
	<20100902145357.GL14214@pengutronix.de>
	<4C8092AB.1050405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: grant.likely@secretlab.ca, spi-devel-general@lists.sourceforge.net,
	s.hauer@pengutronix.de, amit.kucheria@canonical.com,
	linux-arm-kernel@lists.infradead.org
To: Jason Wang <jason77.wang@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4C8092AB.1050405@gmail.com>
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

Hello,

On Fri, Sep 03, 2010 at 02:16:11PM +0800, Jason Wang wrote:
>>>  -	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35()) {
>>> +	/* i.MX51 has two eCSPI and one CSPI controllers, eCSPI controllers a=
re
>>> +	 * not compatible with existing SPI controllers on other i.MX platfor=
ms,
>>> +	 * while CSPI controller is 100% compatible with the one on the i.MX3=
5.
>>> +	 * We set the platform device id to 2 for this CSPI at i.MX51 board i=
nit
>>> +	 * level to distinguish it from two eCSPI controllers.
>>> +	 */
>>>     =

>> This comment is missing in Sascha's driver.  I like it.
>> BTW, I'd like to make use of platform ids in this driver.  This would
>> make this ugly "on imx51 id2 is a cspi" distinction unnecessary.
>>
>>   =

> agree, i like both your and lothar's solution.
> Either platform ids or flags in platform_data.
I suggest to do the cleanup later.  Doing it before adding mx51 support
would make only more work for little benefit.  And then the cleanup
bases on a working version.  I'm willing to implement the platform id
thingy and evaluate it.  But currently I have no time for that.  So I
suggest we choose a mix between your and Sascha's patch for now and I
will check where the cleanup fits in my planning.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
