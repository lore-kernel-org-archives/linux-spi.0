From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v4 2/2] spi-atmel: support inter-word delay
Date: Tue, 29 Jan 2019 15:56:31 +0100
Message-ID: <7a6efd1a-5920-60e5-bc68-dfbe6866e522@norrbonn.se>
References: <20190129083844.20572-1-jonas@norrbonn.se>
 <20190129083844.20572-3-jonas@norrbonn.se>
 <995b3885-254b-7932-8d05-77271a2c070d@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tudor.Ambarus@microchip.com
To: Nicolas.Ferre@microchip.com, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <995b3885-254b-7932-8d05-77271a2c070d@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On 29/01/2019 15:27, Nicolas.Ferre@microchip.com wrote:
> On 29/01/2019 at 09:38, Jonas Bonn wrote:
>> 
>> +	/* DLYBCT adds delays between words.  This is useful for slow devices
>> +	 * that need a bit of time to setup the next transfer.
>> +	 */
>> +	if (spi->word_delay_us) {
> 
> Well...
> 
>> +		csr |= SPI_BF(DLYBCT,
>> +			clamp_t(u8,
>> +				(as->spi_clk/1000000*spi->word_delay_us)>>5,
>> +				1, 255));
> 
> ... why not simplifying to:
> +				0, 255));
> and remove the test altogether, after all?

Hmm... that seemed too easy!  This started out as something else and 
looking at it now I think even the clamp_t() is unnecessary.  The value 
is already 0-255 and the way SPI_BF works any overflow is already 
truncated...  I'll rework this and resubmit once I get some feedback on 
the word_delay_us bits.

Thanks,
/Jonas
