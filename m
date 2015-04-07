From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH 4/5] spi: img-spfi: Setup TRANSACTION register before
 CONTROL register
Date: Tue, 7 Apr 2015 10:59:05 -0700
Message-ID: <CAL1qeaEBzpfrarYA0v3vhtPyQ_RuTQ2mRG4J180XV0aMp6hacA@mail.gmail.com>
References: <1428355747-16822-1-git-send-email-abrestic@chromium.org>
	<1428355747-16822-4-git-send-email-abrestic@chromium.org>
	<20150407112306.GL6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sifan Naeem <sifan.naeem@imgtec.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150407112306.GL6023@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Apr 7, 2015 at 4:23 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Apr 06, 2015 at 02:29:06PM -0700, Andrew Bresticker wrote:
>> From: Sifan Naeem <sifan.naeem@imgtec.com>
>>
>> Setting the transfer length in the TRANSACTION register after the
>> CONTROL register is programmed causes intermittent timeout issues in
>> SPFI transfers when using the SPI framework to control the CS GPIO
>> lines.  To avoid this issue, set transfer length before programming
>> the CONTROL register.
>
> This is fine but it appears to be a bug fix and therefore should have
> been at the start of the series so it could be applied as such and sent
> to Linus.  As it is it depends on the refactoring for prepare() which
> prevents that, please regenerate against Linus' tree so it can be sent
> as a fix.

The bug this patch fixes is only exposed once the driver is converted
to use CS GPIOs (patch 5/5 in this series), so it's not needed unless
that patch is taken.  Really the entire series could be considered
fixes (with patches 2, 3, and 4 being preparatory work for patch 5)
since the switch to using CS GPIOs is to work around the hardware's
buggy CS handling.  That said, support for the first SoC using this
controller (IMG Pistachio) is slated to be merged for 4.1, so I'm not
sure that pulling these fixes into 4.0 is totally necessary.

Thanks,
Andrew
