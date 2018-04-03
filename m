From: Sergey Suloev <ssuloev@orpaltech.com>
Subject: Re: [PATCH v2 1/6] spi: core: handle timeout error from
 transfer_one()
Date: Tue, 3 Apr 2018 19:00:55 +0300
Message-ID: <c0476d75-821f-7a0d-3c3f-270304e7b032@orpaltech.com>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-2-ssuloev@orpaltech.com>
 <20180403155224.GA11578@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180403155224.GA11578@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/03/2018 06:52 PM, Mark Brown wrote:
> On Tue, Apr 03, 2018 at 06:29:00PM +0300, Sergey Suloev wrote:
>> As long as sun4i/sun6i SPI drivers have overriden the default
>> "wait for completion" procedure then we need to properly
>> handle -ETIMEDOUT error from transfer_one().
> Why is this connected to those drivers specifically?

These 2 drivers have their own "waiting" code and not using the code 
from SPI core.
