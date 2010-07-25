From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [spi-devel-general] [PATCH 2/2] SPI: make the moved loopback test
	work
Date: Sun, 25 Jul 2010 01:48:37 -0600
Message-ID: <AANLkTinFqwexhf5g3JMeN2eedRHbo8eTgaD-eqfWkU=B@mail.gmail.com>
References: <AANLkTinm_bvpcQogsTgVy5ZX1MFajVvDxBtVJ056sTyq@mail.gmail.com>
	<812288.2599.qm@web180314.mail.gq1.yahoo.com>
	<AANLkTilqKs4WcSXxrZPUuaTudLD-P8ZeA6ShGyLmAIhi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <david-b@pacbell.net>,
	spi-devel-general@lists.sourceforge.net,
	Anton Vorontsov <avorontsov@mvista.com>,
	linux-arm-kernel@lists.infradead.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTilqKs4WcSXxrZPUuaTudLD-P8ZeA6ShGyLmAIhi@mail.gmail.com>
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

On Tue, Jul 20, 2010 at 3:10 PM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/7/20 David Brownell <david-b@pacbell.net>:
>
>>> No matter how much I look at it, it seems like
>>> all use of this require you to first register
>>> *some* device,
>>
>> OBVIOUSLY. =A0You can't use SPI without a device;
>> it's like any other driver framework in Linux.
>> What else should you expect???
>
> I didn't expect anything else, it just makes it clear that
> the part of my patch registering a dummy device is
> not what is being disagreed upon, so this should be OK.

What's disagreed with is the dummy device knowing the intimate working
details of the SPI bus driver.

g.
