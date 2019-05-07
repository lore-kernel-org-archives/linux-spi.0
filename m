From: kernel@martin.sperl.org
Subject: Re: [PATCH 3/5] spi: core: allow defining time that cs is deasserted
 as a multiple of SCK
Date: Tue, 7 May 2019 12:07:35 +0200
Message-ID: <E177DD3C-49B0-4319-A6F5-45DF9ED02070@martin.sperl.org>
References: <20190223084952.14758-1-kernel@martin.sperl.org>
 <20190223084952.14758-4-kernel@martin.sperl.org>
 <20190223124010.y7lsncknnxoblvgz@wunner.de>
 <CCC6392E-3189-49BE-B04D-3997434184D0@martin.sperl.org>
 <20190224103913.bjw7g6ievr75iawz@wunner.de>
 <0CA42E9E-3297-41EC-8E90-FAE937E892DE@martin.sperl.org>
 <20190226113720.GB7082@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 linux-spi <linux-spi@vger.kernel.org>, Eric Anholt <eric@anholt.net>,
 Lukas Wunner <lukas@wunner.de>, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190226113720.GB7082@sirena.org.uk>
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


> On 26.02.2019, at 12:37, Mark Brown <broonie@kernel.org> wrote:
> 
> On Sun, Feb 24, 2019 at 12:03:33PM +0100, kernel@martin.sperl.org wrote:
> 
>> Some devices - like the mcp2517fd -  have for example an internal PLL
>> based on an external clock. So during setup you have to use speed_hz 
>> of <clock_hz> / 2 (or 4MHz at most) and only when PLL is in sync we 
>> may be using speed_hz from the dt (or less if a module parameter is
>> used to limit ourselves further)
> 
>> So the initial setup would not be able to help here - and every
>> bus controller would now be required to implement setup.
> 
>> It also means open coding the calculations in each driver that 
>> needs something like this.
> 
>> Thus it is - imo - in the right location to support it in spi core.
> 
> I agree, this feature makes sense to me.

Is there anything that really block this patch?

Do you want a rebase?
Anything else?

Martin
