From: Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH V2 7/8] spi: spi-qcom-qspi: Add interconnect support
Date: Fri, 20 Mar 2020 11:05:42 +0530
Message-ID: <f8f7041b-c21e-2c2c-a6e7-b92e7cc3e90b@codeaurora.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-8-git-send-email-akashast@codeaurora.org>
 <20200314005817.GN144492@google.com>
 <3aeb3083-2a31-b269-510d-eb608ff14ce5@codeaurora.org>
 <CAE=gft58QsgTCUHMHKJhcM9ZxAeMiY16CrbNv2HaTCRqwtmt7A@mail.gmail.com>
 <e2ee1a60-a379-5c78-355a-64aad451a944@codeaurora.org>
 <CAE=gft4xL9+GN2NrM9ewyPg0Fog3pnf_sLGjWRNOg7KynNh-Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wsa@the-dreams.de, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
To: Evan Green <evgreen@chromium.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAE=gft4xL9+GN2NrM9ewyPg0Fog3pnf_sLGjWRNOg7KynNh-Dg@mail.gmail.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Evan,
>> IIUC, you meant to say struct icc_req(inside icc_path) will be saving
>> avg_bw and peak_bw so no need to save it outside icc_path?
> Correct, it seems silly to store the same set of values twice in the
> framework, but with different semantics about who's watching it.
> -Evan

Thanks for clarification! Yeah make sense not to introduce the structure 
in ICC framework

Regards,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
