CoD.AmmoCounter = {}
CoD.AmmoCounter.TextHeight = 28
CoD.AmmoCounter.LowAmmoFadeTime = 500
CoD.AmmoCounter.PulseDuration = 500

CoD.AmmoCounter.new = function(positionArgs)
    local element = LUI.UIElement.new(positionArgs)
    element:registerAnimationState("hide", { alphaMultiplier = 0 })
    element:registerAnimationState("show", { alphaMultiplier = 1 })
    element:animateToState("hide")

    local padding = 36
    local panel = LUI.UIElement.new({
        left = -90,
        top = padding,
        right = 10,
        bottom = padding + 40,
        leftAnchor = true,
        topAnchor = true,
        rightAnchor = false,
        bottomAnchor = false
    })
    element:addElement(panel)

    local textHeight = CoD.AmmoCounter.TextHeight
    element.ammoLabel = LUI.UIText.new({
        left = -1,
        top = -4,
        right = 0,
        bottom = 4,
        leftAnchor = false,
        topAnchor = true,
        rightAnchor = true,
        bottomAnchor = true,
        alpha = 1
    })

    element.ammoLabel:setFont(CoD.font.Big)
    element.ammoLabel:registerAnimationState("pulse_low", { alpha = 1 })
    element.ammoLabel:registerAnimationState("pulse_high", { alpha = 0.5 })
    element.ammoLabel:registerEventHandler("transition_complete_pulse_high", CoD.AmmoCounter.Ammo_PulseHigh)
    element.ammoLabel:registerEventHandler("transition_complete_pulse_low", CoD.AmmoCounter.Ammo_PulseLow)
    panel:addElement(element.ammoLabel)

    element:registerEventHandler("hud_update_refresh", CoD.AmmoCounter.UpdateVisibility)
    element:registerEventHandler("hud_update_weapon", CoD.AmmoCounter.UpdateVisibility)
    element:registerEventHandler("hud_update_ammo", CoD.AmmoCounter.UpdateAmmo)
    return element
end

CoD.AmmoCounter.UpdateAmmo = function(f2_arg0, f2_arg1)
    local ammoString = f2_arg1.ammoInClip .. "/" .. f2_arg1.ammoStock
    if f2_arg1.ammoInDWClip then
        ammoString = f2_arg1.ammoInDWClip .. " | " .. ammoString
    end

    f2_arg0.ammoLabel:setText(ammoString)
    if f2_arg1.lowClip and f2_arg0.lowAmmo ~= true then
        f2_arg0.lowAmmo = true

        if CoD.isZombie then
            f2_arg0.ammoLabel:animateToState("pulse_high", CoD.AmmoCounter.LowAmmoFadeTime)
        end
    elseif f2_arg1.lowClip ~= true and f2_arg0.lowAmmo == true then
        f2_arg0.lowAmmo = nil

        if CoD.isZombie then
            f2_arg0.ammoLabel:animateToState("default", CoD.AmmoCounter.LowAmmoFadeTime)
        end
    end
end

CoD.AmmoCounter.ShouldHideAmmoCounter = function(f3_arg0, f3_arg1)
    if f3_arg0.weapon ~= nil then
        if Engine.IsWeaponType(f3_arg0.weapon, "melee") then
            return true
        elseif CoD.isZombie == true and (f3_arg1.inventorytype == 1 or f3_arg1.inventorytype == 2) then
            return true
        elseif CoD.isZombie == true and
            (Engine.IsWeaponType(f3_arg0.weapon, "gas") or Engine.IsOverheatWeapon(f3_arg0.weapon)) then
            return true
        end
    end
    return false
end

CoD.AmmoCounter.UpdateVisibility = function(f4_arg0, f4_arg1)
    local f4_local0 = f4_arg1.controller
    if f4_arg1.weapon ~= nil then
        f4_arg0.weapon = f4_arg1.weapon
    end
    if CoD.AmmoCounter.ShouldHideAmmoCounter(f4_arg0, f4_arg1) then
        if f4_arg0.visible == true then
            f4_arg0:animateToState("hide")
            f4_arg0.visible = nil
        end
        f4_arg0:dispatchEventToChildren(f4_arg1)
    elseif f4_arg0.visible ~= true then
        f4_arg0:animateToState("show")
        f4_arg0.visible = true
    end
end

CoD.AmmoCounter.Ammo_PulseHigh = function(f5_arg0, f5_arg1)
    if f5_arg1.interrupted ~= true then
        f5_arg0:animateToState("pulse_low", CoD.AmmoCounter.LowAmmoFadeTime, true, false)
    end
end

CoD.AmmoCounter.Ammo_PulseLow = function(f6_arg0, f6_arg1)
    if f6_arg1.interrupted ~= true then
        f6_arg0:animateToState("pulse_high", CoD.AmmoCounter.LowAmmoFadeTime, false, true)
    end
end

