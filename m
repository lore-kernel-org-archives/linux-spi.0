From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH] spi/pl022: make sure the chip_info dev pointer is set
Date: Fri, 1 Oct 2010 12:37:57 +0200
Message-ID: <4CA5BA05.3000605@stericsson.com>
References: <1285839648-7368-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTimZXF-ntBSROV2pVN+Td1Bek7C5DtKZTQgXY=Wt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTimZXF-ntBSROV2pVN+Td1Bek7C5DtKZTQgXY=Wt@mail.gmail.com>
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

Grant Likely wrote:

>>        } else {
>> +               /* Users should not set this field */
>> +               chip_info->dev = &spi->dev;
>>                dev_dbg(&spi->dev,
>>                        "using user supplied controller_data settings\n");
>>        }
> 
> Nack.  data passed to a driver via the controller_data must be
> immutable as far as the device driver is concerned.

I posted another patch removing it instead, that's obviously the
right thing to do...

Yours,
Linus Walleij
