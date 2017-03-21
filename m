From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH 2/2] spi: imx: fix use of native chip-selects with
 devicetree
Date: Tue, 21 Mar 2017 21:53:52 +1000
Message-ID: <942cfc4b-445b-ca51-1823-2391cea62abf@linux-m68k.org>
References: <1489726983-17706-1-git-send-email-gerg@linux-m68k.org>
 <1489726983-17706-3-git-send-email-gerg@linux-m68k.org>
 <f1cf2001-28b4-6a74-b98a-13336d74ff9d@mentor.com>
 <4a8449d9-cc38-d642-0853-246f46ee7059@linux-m68k.org>
 <20170321080551.ie4xm5hr3fki365s@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi@vger.kernel.org,
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, kernel@pengutronix.de,
 fabio.estevam@nxp.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170321080551.ie4xm5hr3fki365s@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On 21/03/17 18:05, Uwe Kleine-K=F6nig wrote:
> On Tue, Mar 21, 2017 at 12:05:20PM +1000, Greg Ungerer wrote:
>> On 20/03/17 23:22, Vladimir Zapolskiy wrote:
>>> For that type of bindings locally I have a hackish spi-imx driver chang=
e,
>>> which supports this option, but I'm unsure if it is universal enough.
>>
>> Do you mean supporting no cs-gpios tag?
>> That would be nice, but it would seem not many users of this are
>> using native chip selects.
>
> The reason for this is that the native chip selects are less flexible
> than gpios because you cannot control when they deassert. IIRC they do
> it too much for some chips. So the only reason to stick to them is that
> on some SoCs not all pins have a GPIO function. Not sure if transfer
> speed is another reason, but I would expect that the gain isn't that
> big.

For the particular SPI device I am using, a Silicon Labs 32260,
it actually wants the assertion and de-assertion of the chip-select
between each byte. So it is the only way it can work for me.

Regards
Greg
