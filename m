From: Sergey Suloev <ssuloev@orpaltech.com>
Subject: Re: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
Date: Thu, 5 Apr 2018 16:44:16 +0300
Message-ID: <8159c3a5-af74-9f13-aedb-7ecc708bdff6@orpaltech.com>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-4-ssuloev@orpaltech.com>
 <20180404065048.n76r3ytuznd6fqsl@flea>
 <a6044902-8977-3ce1-d7d5-c6797341a5d0@orpaltech.com>
 <20180405091913.ky4dnmszoobn2xry@flea>
 <ee4adb1e-caf6-32f6-33d6-d8dd94d232cf@orpaltech.com>
 <20180405131735.GB12349@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180405131735.GB12349@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/05/2018 04:17 PM, Mark Brown wrote:
> On Thu, Apr 05, 2018 at 12:59:35PM +0300, Sergey Suloev wrote:
>> On 04/05/2018 12:19 PM, Maxime Ripard wrote:
>>> The point of that patch was precisely to allow to send more data than
>>> the FIFO. You're breaking that behaviour without any justification,
>>> and this is not ok.
>> I am sorry, but you can't. That's a hardware limitation.
> Are you positive about that?  Normally you can add things to hardware
> FIFOs while they're being drained so so long as you can keep data
> flowing in at least as fast as it's being consumed.

Well, normally yes, but this is not the case with the hardware that I 
own. My a20 (BPiM1+) and a31 (BPiM2) boards behaves differently. With a 
transfer larger than FIFO then TC interrupt never happens.
