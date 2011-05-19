From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] spi/pl022: timeout on polled transfer v2
Date: Thu, 19 May 2011 19:36:23 +0200
Message-ID: <BANLkTi=mQbPt9rcqEVyMLy3rkF2D7FMh=g@mail.gmail.com>
References: <1305821134-26147-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTi=s4nzi=5f+Vvh3ABuspnKXQVUfLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net, Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Magnus Templing <magnus.templing@stericsson.com>
To: Vitaly Wool <vitalywool@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BANLkTi=s4nzi=5f+Vvh3ABuspnKXQVUfLw@mail.gmail.com>
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

2011/5/19 Vitaly Wool <vitalywool@gmail.com>:

>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(SPI=
_POLLING_TIMEOUT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (pl022->tx < pl022->tx_end || pl022-=
>rx < pl022->rx_end) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 time =3D jiffies;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0readwriter(pl022);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(time, timeo=
ut)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&=
pl022->adev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: timeo=
ut!\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 message->s=
tate =3D STATE_ERROR;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> just out of curiosity: is it a busy wait? Looks like it is...

Yep that's the polling mode part. IRQ and DMA mode should
be the norm I guess.

Magnus: do you have a specific use case for this thing?

Yours,
Linus Walleij
