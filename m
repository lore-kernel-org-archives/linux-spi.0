From: Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH v2] spi: fsl-spi: use of_iomap() to map parameter ram on CPM1
Date: Wed, 22 Apr 2015 22:52:48 +0200
Message-ID: <CAOiHx=km-tquvxPm41ONyJ7tqTMObcD5T6tK8RLHPpr+RvLPDA@mail.gmail.com>
References: <20150422141721.D3F8C1A242E@localhost.localdomain> <CAOiHx==hwBGsYwT6MFV-ur=wnnUmqw_GF7sN8KOwUho3fz5uew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-spi@vger.kernel.org
To: Christophe Leroy <christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOiHx==hwBGsYwT6MFV-ur=wnnUmqw_GF7sN8KOwUho3fz5uew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Apr 22, 2015 at 10:46 PM, Jonas Gorski <jogo@openwrt.org> wrote:
>> ---
>>  v2: Use devm_ioremap_resource() instead of_iomap()
>
> Your subject and commitlog still talk about using of_iomap(), you need
> to update them too.

Hmm I didn't see the V3. Ignore this comment (the other one still applies).

Regards
Jonas
