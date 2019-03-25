From: kernel@martin.sperl.org
Subject: Re: [PATCH V2 9/9] spi: bcm2835aux: make the polling duration limits
 configurable
Date: Mon, 25 Mar 2019 10:49:48 +0100
Message-ID: <63AAA1F6-25FB-4C58-9F9B-9377E94CB3B2@martin.sperl.org>
References: <20190324175002.28969-1-kernel@martin.sperl.org>
 <20190324175002.28969-10-kernel@martin.sperl.org>
 <4da737f4-acf2-c70d-59cd-0efdf2ec21d4@i2se.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 Hubert Denkmair <h.denkmair@intence.de>, linux-arm-kernel@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4da737f4-acf2-c70d-59cd-0efdf2ec21d4@i2se.com>
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


> On 25.03.2019, at 10:44, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> Hi Martin,
> 
> Am 24.03.19 um 18:50 schrieb kernel@martin.sperl.org:
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> +/* define polling limits */
>> +unsigned int polling_limit_us = 30;
>> +module_param(polling_limit_us, uint, 0664);
>> +MODULE_PARM_DESC(polling_limit_us,
>> +		 "time in us to run a transfer in polling mode\n");
>> +
> could you please document the case polling_limit_us = 0 ?

Means no polling under any circumstances - I can add it as a comment in V3.

martin
