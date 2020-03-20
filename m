From: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V2 3/8] soc: qcom-geni-se: Add interconnect support to fix
 earlycon crash
Date: Fri, 20 Mar 2020 15:52:27 +0530
Message-ID: <a7227a1f-00a1-0818-80f3-904fe264f864@codeaurora.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-4-git-send-email-akashast@codeaurora.org>
 <20200313204441.GJ144492@google.com>
 <1f86fdf0-df7c-4e4a-d4d8-8b0162e52cb4@codeaurora.org>
 <20200317182910.GR144492@google.com>
 <3831b33c-93ee-e5e0-fcfb-530b4738f930@codeaurora.org>
 <20200319194332.GA60149@google.com>
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
To: "Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> Evan Green"
        <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200319194332.GA60149-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Evan, Matthias,

On 3/20/2020 1:13 AM, Matthias Kaehlcke wrote:
> On Wed, Mar 18, 2020 at 02:24:35PM +0530, Akash Asthana wrote:
>> Hi Matthias,
>>
>> On 3/17/2020 11:59 PM, Matthias Kaehlcke wrote:
>>> Hi Akash,
>>>
>>> On Tue, Mar 17, 2020 at 04:27:47PM +0530, Akash Asthana wrote:
>>>> Hi Matthias,
>>>>
>>>> On 3/14/2020 2:14 AM, Matthias Kaehlcke wrote:
>>>>> Hi Akash,
>>>>>
>>>>> On Fri, Mar 13, 2020 at 06:42:09PM +0530, Akash Asthana wrote:
>>>>>> V1 patch@https://patchwork.kernel.org/patch/11386469/ caused SC7180 system
>>>>>> to reset at boot time.
>>>>> The v1 patch isn't relevant in the commit message, please just describe the
>>>>> problem. Also the crash only occurs when earlycon is used.
>>>> ok
>>>>>> As QUP core clock is shared among all the SE drivers present on particular
>>>>>> QUP wrapper, the reset seen is due to earlycon usage after QUP core clock
>>>>>> is put to 0 from other SE drivers before real console comes up.
>>>>>>
>>>>>> As earlycon can't vote for it's QUP core need, to fix this add ICC
>>>>>> support to common/QUP wrapper driver and put vote for QUP core from
>>>>>> probe on behalf of earlycon and remove vote during sys suspend.
>>>>> Only removing the vote on suspend isn't ideal, the system might never get
>>>>> suspended. That said I don't have a really good alternative suggestion.
>>>>>
>>>>> One thing you could possibly do is to launch a delayed work, check
>>>>> console_device() every second or so and remove the vote when it returns
>>>>> non-NULL. Not claiming this would be a great solution ...
>>>>>
>>>>> The cleanest solution might be a notifier when the early console is
>>>>> unregistered, it seems somewhat over-engineered though ... Then again
>>>>> other (future) uart drivers with interconnect support might run into
>>>>> the same problem.
>>>> We are hitting this problem because QUP core clocks are shared among all the
>>>> SE driver present in particular QUP wrapper, if other HW controllers has
>>>> similar architecture we will hit this issue.
>>>>
>>>> How about if we expose an API from common driver(geni-se) for putting QUP
>>>> core BW vote to 0.
>>>>
>>>> We call this from console probe just after uart_add_one_port call (console
>>>> resources are enabled as part of this call) to put core quota to 0 on behalf
>>>> of earlyconsole?
>>>   From my notes from earlier debugging I have doubts this would work:
>>>
>>>     There is a short window where the early console and the 'real' console coexist:
>>>
>>>     [    3.858122] printk: console [ttyMSM0] enabled
>>>     [    3.875692] printk: bootconsole [qcom_geni0] disabled
>>>
>>>     The reset probably occurs when the early console tries to write, but the ICC
>>>     is effectively disabled because ttyMSM0 and the other geni ports are runtime
>>>     suspended.
>> Code flow from console driver probe(qcom_geni_serial.c)
>>
>> uart_add_one_port--->uart_configure_port--->{ 1) uart_change_pm(enable
>> console resources)  2)register_console(boot to real console switch happens
>> here)}
>>
>> Console resources are not disabled from anywhere before the switch happens
>> completely. I meant to say until we saw below logs.
>>
>> [    3.875692] printk: bootconsole [qcom_geni0] disabled
>>
>> I think the board reset issue cannot occur during the window where early
>> console and 'real' console coexist.
> Thanks for the clarification! Indeed my notes were only a hypothesis, I
> don't see evidence that there is an actual downvote shortly after console
> registration.
>
>> I have validated proposed solution by me, it is working fine.
>>
>> Currently voting is done for every QUP and not only to which earlycon is
>> connect, with the above approach we can't remove vote from other QUPs.
>>
>> However we can limit voting only to earlycon QUP by removing interconnect
>> from DT node of other QUPs.
>>
>> I am not sure how clean is this solution.
> I'm more inclined towards a solution along the lines of what Evan
> proposed, i.e. delaying the votes (either in geni or ICC) until we
> are ready.

Based on discussion I think the delayed solution is most suited if 
implemented in ICC core because other ICC client might face the similar 
problem.

However for geni case I am more inclined towards below proposed solution.

-----------------------------------------------------------------------------------------------------

How about if we expose an API from common driver(geni-se) for putting QUP
core BW vote to 0.

We call this from console probe just after uart_add_one_port call (console
resources are enabled as part of this call) to put core quota to 0 on behalf
of earlyconsole?
---------------------------------------------------------------------------

I think below are the pros and cons for above solution.

Pros:

1) Not only it'll solve the current issue also it'll lay foundation to 
support earlyconsole without having a real console. In future if needed 
we can enable rest of the earlyconsole resources(SE clocks) from common 
driver to make it independent of real console.

2) Inorder to solve bug:120934049(Add runtime PM support to common 
driver and move enablement/disablement of AHB clocks there) reported by 
Stephen Boyd, we'll end up adding ICC support to this driver because as 
per HPG the order of enabling the QUP clocks should be 
(Core-->AHB-->SE(per engine)). So we need to have the minimal possible 
vote on QUP core before enabling AHB clocks.

I agree still we have keep earlycon fix as it is(vote from common driver 
probe and remove once real console is up) .

I mentioned above bug in case it seems silly to add ICC support to 
common driver just for earlyconsole fix.

Cons:

1) As Evan mentioned and I agree that the whole house of cards comes 
down if we replace these votes in the wrong order. But I think this is 
very unlikely to happen once fixed.

2) As Matthias mentioned we are voting for all the QUPs regardless 
earlycon is present or not, I think this is HW limitation and we have to 
live with it.

Even if I try something like below the QUP1 can come up before 
QUP2(console) and child of QUP1 can remove vote from share QUP clocks.

if (of_get_compatible_child(pdev->dev.of_node, "qcom,geni-debug-uart")) {

     ret = icc_set_bw(wrapper->icc_path_geni_to_core, Bps_to_icc(1000),

         Bps_to_icc(1000));

}


Thanks,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
