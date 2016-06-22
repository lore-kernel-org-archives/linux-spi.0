From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [RFC] regmap: Add regmap_pipe_read API
Date: Wed, 22 Jun 2016 11:32:20 +0300
Message-ID: <f3524d45-b266-056d-05b7-df2d4c007921@intel.com>
References: <7ca3857aa8869a1e1f4709860f57f7d92abf1c6b.1466089603.git.leonard.crestez@intel.com>
 <20160621184251.GC28202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	linux-i2c@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160621184251.GC28202@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 06/21/2016 09:42 PM, Mark Brown wrote:
> On Thu, Jun 16, 2016 at 06:24:36PM +0300, Crestez Dan Leonard wrote:
> 
>> +		val = ((u8*)val) + read_len;
> 
> This cast looks broken, you should be able to do pointer arithmetic on
> void pointers as though they were char *.
> 
Pointer arithmetic on void* is not standard C, it's a GCC extension. I
know that GCC extensions are allowed for the kernel but is it really
encouraged to rely on them this way?

Anyway, are my concerns about the regmap_bus implementation for SPMI
valid? In theory this could be submitted in it's present form and let
regmap+spmi users

If this API is otherwise fine I can just resend this marked as [PATCH]
with the cast removed and some rearranged comments.

-- 
Regards,
Leonard
