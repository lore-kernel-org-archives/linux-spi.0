From: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V2 2/8] soc: qcom: geni: Support for ICC voting
Date: Tue, 17 Mar 2020 15:28:59 +0530
Message-ID: <faf3cbea-bce7-3592-cfae-93613a8c7e26@codeaurora.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-3-git-send-email-akashast@codeaurora.org>
 <20200313164207.GH144492@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
To: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200313164207.GH144492-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Matthias,

On 3/13/2020 10:12 PM, Matthias Kaehlcke wrote:
> Hi Akash,
>
> On Fri, Mar 13, 2020 at 06:42:08PM +0530, Akash Asthana wrote:
>> Add necessary macros and structure variables to support ICC BW
>> voting from individual SE drivers.
>>
>> Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>> Changes in V2:
>>   - As per Bjorn's comment dropped enums for ICC paths, given the three
>>     paths individual members
>>
>>   include/linux/qcom-geni-se.h | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
>> index dd46494..eaae16e 100644
>> --- a/include/linux/qcom-geni-se.h
>> +++ b/include/linux/qcom-geni-se.h
>> @@ -6,6 +6,8 @@
>>   #ifndef _LINUX_QCOM_GENI_SE
>>   #define _LINUX_QCOM_GENI_SE
>>   
>> +#include <linux/interconnect.h>
>> +
>>   /* Transfer mode supported by GENI Serial Engines */
>>   enum geni_se_xfer_mode {
>>   	GENI_SE_INVALID,
>> @@ -33,6 +35,15 @@ struct clk;
>>    * @clk:		Handle to the core serial engine clock
>>    * @num_clk_levels:	Number of valid clock levels in clk_perf_tbl
>>    * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
>> + * @icc_path_geni_to_core:	ICC path handle for geni to core
>> + * @icc_path_cpu_to_geni:	ICC path handle for cpu to geni
>> + * @icc_path_geni_to_ddr:	ICC path handle for geni to ddr
>> + * @avg_bw_core:	Average bus bandwidth value for QUP core 2x clock
>> + * @peak_bw_core:	Peak bus bandwidth value for QUP core 2x clock
>> + * @avg_bw_cpu:		Average bus bandwidth value for CPU
>> + * @peak_bw_cpu:	Peak bus bandwidth value for CPU
>> + * @avg_bw_ddr:		Average bus bandwidth value for DDR
>> + * @peak_bw_ddr:	Peak bus bandwidth value for DDR
>>    */
>>   struct geni_se {
>>   	void __iomem *base;
>> @@ -41,6 +52,15 @@ struct geni_se {
>>   	struct clk *clk;
>>   	unsigned int num_clk_levels;
>>   	unsigned long *clk_perf_tbl;
>> +	struct icc_path *icc_path_geni_to_core;
>> +	struct icc_path *icc_path_cpu_to_geni;
>> +	struct icc_path *icc_path_geni_to_ddr;
>> +	unsigned int avg_bw_core;
>> +	unsigned int peak_bw_core;
>> +	unsigned int avg_bw_cpu;
>> +	unsigned int peak_bw_cpu;
>> +	unsigned int avg_bw_ddr;
>> +	unsigned int peak_bw_ddr;
> Those are a lot of new individual struct members. How about clustering
> them, e.g.:
>
> struct geni_icc_path {
> 	struct icc_path *path;
> 	unsigned int avg_bw;
> 	unsigned int peak_bw;
> };
I guess it would be better to add this structure  ICC driver as you 
suggested@https://patchwork.kernel.org/patch/11436905/.
> struct geni_iccs_paths {
> 	struct geni_icc_path to_core;
> 	struct geni_icc_path from_cpu;
> 	struct geni_icc_path to_ddr;
> };
>
> And 'struct geni_se' just gets this entry:
>
> 	struct geni_icc_paths icc;
>
> or alternatively three 'struct geni_icc_path' entries.

ok

Thanks for reviewing.

Regards

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
