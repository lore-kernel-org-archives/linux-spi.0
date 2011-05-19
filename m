From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] spi/pl022: timeout on polled transfer
Date: Thu, 19 May 2011 15:23:24 +0200
Message-ID: <BANLkTinrk-FjMy1trDnsxwT_NTgQ5x_8Rg@mail.gmail.com>
References: <1305807191-11704-1-git-send-email-linus.walleij@stericsson.com>
	<20110519124454.GC2219@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Linus Walleij <linus.walleij@stericsson.com>,
	Magnus Templing <magnus.templing@stericsson.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net, Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110519124454.GC2219@pengutronix.de>
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

On Thu, May 19, 2011 at 2:44 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:

> Hi,
>
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: insert a timeout so we don't hang he=
re indefinitely */
>> - =A0 =A0 =A0 =A0 =A0 =A0 while (pl022->tx < pl022->tx_end || pl022->rx =
< pl022->rx_end)
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(SPI_POL=
LING_TIMEOUT);
>
> Won't you miss the transfer if you get interrupted here longer than
> SPI_POLLING_TIMEOUT?

Yeah... preempted for a second hm.

>> + =A0 =A0 =A0 =A0 =A0 =A0 while (pl022->tx < pl022->tx_end || pl022->rx =
< pl022->rx_end) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeou=
t)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&pl02=
2->adev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: timeout!\=
n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 message->state=
 =3D STATE_ERROR;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 readwriter(pl022);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }

What about we move readerwriter() above if (time_after...) then it atleast
gets one chance to run even if we're preempted for 10 seconds.

Any other design patterns that'd be better?

Yours,
Linus Walleij
